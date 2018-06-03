resource "aws_s3_bucket" "bucket_s3" {
  bucket = "${var.bucket_name}"
  acl    = "private"
  tags {
    Name        = "My-MCH-Bucket"
    Environment = "Dev"
  }
    versioning {
    enabled = true
  }
}

