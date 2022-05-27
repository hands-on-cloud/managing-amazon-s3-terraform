#creating dynamoDB table for state locking:
resource "aws_dynamodb_table" "state_lock_table" {
  name           = var.table_name
  billing_mode   = "PROVISIONED"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "LockID" #terraform requires this for state locking

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    "Project" = "hands-on.cloud"
  }
}