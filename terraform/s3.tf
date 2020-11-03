resource "aws_s3_bucket" "bookstore_staging_bucket" {
  bucket = "bookstore-staging-storage"
  acl    = "private"
}
