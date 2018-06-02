resource "aws_iam_policy" "policy" {
  name_prefix = "${var.name_prefix}"
  description = "A test policy"
  policy      = "${file("policy-s3-bucket.json")}"
}
