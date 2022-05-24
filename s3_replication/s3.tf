#create source bucket :
resource "aws_s3_bucket" "src" {
  provider = aws.source
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

#create destination bucket:
resource "aws_s3_bucket" "dest" {
  provider = aws.destination
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