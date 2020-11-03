resource "aws_ecr_repository" "bookstore_app" {
  name = "bookstore/app"
}

resource "aws_ecr_repository" "bookstore_web" {
  name = "bookstore/web"
}
