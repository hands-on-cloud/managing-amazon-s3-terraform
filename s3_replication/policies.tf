#IAM policy - STS Assume Role for S3:
data "aws_iam_policy_document" "sts" {
  statement {
    sid     = "S3AssumeRole"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["s3.amazonaws.com"]
    }
    effect = "Allow"
  }
}

#IAM Policy - S3 CRR :
data "aws_iam_policy_document" "replication" {

  #bucket level permissions:
  statement {
    actions   = ["s3:CreateBucketReplication", "s3:ListBucket"]
    resources = ["${aws_s3_bucket.src.arn}"]
    effect    = "Allow"
  }

  #object level permissions - source bucket:
  statement {
    actions   = ["s3:GetObjectVersionForReplication", "s3:GetObjectVersionAcl", "s3:GetObjectVersionTagging"]
    effect    = "Allow"
    resources = ["${aws_s3_bucket.src.arn}/*"]

  }

  #object level permissions - destination bucket:

  statement {
    actions  = ["s3:ReplicateObject", "s3:ReplicateDelete", "s3:ReplicateTags"]
    effect   = "Allow"
    resource = "${aws_s3_bucket.dest.arn}/*"
  }
}