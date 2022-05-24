#create source bucket :
resource "aws_s3_bucket" "src" {
  provider      = aws.source
  bucket_prefix = var.src_bucket_prefix
}

#enable versioning - source bucket:
resource "aws_s3_bucket_versioning" "src_versioning" {
  provider = aws.source

  bucket = aws_s3_bucket.src.id
  versioning_configuration {
    status = "Enabled"
  }
}

#create replication configuration for source bucket:
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
  }
}

#create destination bucket:
resource "aws_s3_bucket" "dest" {
  provider      = aws.destination
  bucket_prefix = var.dest_bucket_prefix
}

#enable versioning - destination bucket:
resource "aws_s3_bucket_versioning" "dest_versioning" {
  provider = aws.destination

  bucket = aws_s3_bucket.dest.id
  versioning_configuration {
    status = "Enabled"
  }
}

