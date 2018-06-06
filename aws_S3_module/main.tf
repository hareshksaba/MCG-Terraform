#Create s3 bucket. 
#Name for bucket is from variables
#Tag bucket for easy access
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

#Create new IAM policy to get and list items
resource "aws_iam_policy" "s3_policy" {
  name        = "s3-policy"
  description = "A s3 policy"
  policy      = "${file("${path.module}/s3_iam_policy.json")}"
}


