#terraform s3 : create source bucket :
resource "aws_s3_bucket" "src" {
  provider      = aws.source
  bucket_prefix = var.src_bucket_prefix
}

#terraform s3 : enable versioning - source bucket:
resource "aws_s3_bucket_versioning" "src_versioning" {
  provider = aws.source

  bucket = aws_s3_bucket.src.id
  versioning_configuration {
    status = "Enabled"
  }
}

#terraform s3 : create replication configuration for source bucket:
resource "aws_s3_bucket_replication_configuration" "replication" {
  provider = aws.source
  # Must have bucket versioning enabled first
  depends_on = [aws_s3_bucket_versioning.src_versioning]

  role   = aws_iam_role.replication.arn
  bucket = aws_s3_bucket.src.id

  rule {
    status = "Enabled"
    destination {
      bucket        = aws_s3_bucket.dest.arn
      storage_class = "STANDARD"
    }

    #perform replication only objects having this tag:
    filter {
      tag {
        key   = "replication"
        value = "true"
      }
    }

    delete_marker_replication {
      status = "Disabled"
    }
  }
}

#terraform s3 : create destination bucket:
resource "aws_s3_bucket" "dest" {
  provider      = aws.destination
  bucket_prefix = var.dest_bucket_prefix
}

#terraform s3 : enable versioning - destination bucket:
resource "aws_s3_bucket_versioning" "dest_versioning" {
  provider = aws.destination

  bucket = aws_s3_bucket.dest.id
  versioning_configuration {
    status = "Enabled"
  }
}

#terraform s3 : upload object to source bucket to check replication
resource "aws_s3_object" "object" {
  provider = aws.source

  bucket = aws_s3_bucket.src.id
  key    = basename(var.upload_path)
  source = var.upload_path

  tags = {
    "replication" = "true" #tag to allow replication
  }
}