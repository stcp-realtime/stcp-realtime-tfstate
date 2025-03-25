# ---------------------------------------------------------------------------------------------------------------------
# DynamoDB
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_dynamodb_table" "dynamodb_locks" {
  #checkov:skip=CKV_AWS_119: DynamoDB does not contain sensitive data as it only contains the terraform checksum lock value
  #checkov:skip=CKV_AWS_28: PITR not active right now, will evaluate later if needed for Prod
  #checkov:skip=CKV2_AWS_16: Autoscaling disabled to keep costs down
  name           = "${var.project_name}-${var.environment}"
  billing_mode   = "PROVISIONED"
  read_capacity  = 15
  write_capacity = 15
  hash_key       = "LockID"
  stream_enabled = false

  attribute {
    name = "LockID"
    type = "S"
  }
}
