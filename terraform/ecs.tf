data "aws_ecs_task_definition" "bookstore_task_definition" {
  task_definition = aws_ecs_task_definition.bookstore_task_definition.family
}

data "template_file" "bookstore_task_definition_template" {
  template = file("templates/bookstore_td.json")
}

resource "aws_ecs_cluster" "bookstore_ecs_cluster" {
  name = "bookstore"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

resource "aws_ecs_task_definition" "bookstore_task_definition" {
  container_definitions = data.template_file.bookstore_task_definition_template.rendered

  cpu                      = "700"
  family                   = "bookstore-staging"
  memory                   = "1500"
  network_mode             = "bridge"
  requires_compatibilities = ["EC2"]
  tags                     = {}

  volume {
    name = "assets"
  }

  volume {
    host_path = "/postgres"
    name      = "volume-1"
  }

  volume {
    host_path = "/redis"
    name      = "volume-2"
  }
}

resource "aws_ecs_service" "bookstore_staging_ecs_service" {
  name            = "bookstore-staging"
  cluster         = aws_ecs_cluster.bookstore_ecs_cluster.id
  task_definition = "${aws_ecs_task_definition.bookstore_task_definition.family}:${max("${aws_ecs_task_definition.bookstore_task_definition.revision}", "${data.aws_ecs_task_definition.bookstore_task_definition.revision}")}"

  deployment_maximum_percent         = 100
  deployment_minimum_healthy_percent = 0
  desired_count                      = 1
  health_check_grace_period_seconds  = 0
  launch_type                        = "EC2"
  tags                               = {}

  deployment_controller {
    type = "ECS"
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.bookstore_staging_tg.arn
    container_name   = "web"
    container_port   = 80
  }

  ordered_placement_strategy {
    field = "attribute:ecs.availability-zone"
    type  = "spread"
  }

  ordered_placement_strategy {
    field = "instanceId"
    type  = "spread"
  }

  lifecycle {
    ignore_changes = [task_definition]
  }
}
