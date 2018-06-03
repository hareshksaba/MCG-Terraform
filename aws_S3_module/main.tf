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

resource "aws_iam_policy" "s3_policy" {
  name        = "s3-policy"
  description = "A s3 policy"
  policy      = "${file("${path.module}/s3_iam_policy.json")}"
}


