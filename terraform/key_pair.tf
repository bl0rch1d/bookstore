resource "aws_key_pair" "bookstore_cluster" {
  key_name   = var.SSH_KEY_NAME
  public_key = file("${path.root}/ssh_keys/${var.SSH_KEY_NAME}.pub")
  tags       = {}
}
