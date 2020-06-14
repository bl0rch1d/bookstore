data "template_file" "user_data" {
  template = file("${path.module}/templates/user_data.sh")

  vars = {
    ECS_CLUSTER = aws_ecs_cluster.bookstore_ecs_cluster.name
  }
}

data "aws_ami" "amazon_ami" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn-ami-2018.03.v-amazon-ecs-optimized"]
  }

  owners = ["amazon"]
}

resource "aws_instance" "bookstore_cluster_instance" {
  ami                    = data.aws_ami.amazon_ami.id
  instance_type          = var.ECS_INSTANCE_TYPE
  key_name               = aws_key_pair.bookstore_cluster.key_name
  vpc_security_group_ids = [aws_security_group.bookstore_staging.id]
  user_data              = base64encode(data.template_file.user_data.rendered)
  iam_instance_profile   = "ecsInstanceRole"
}
