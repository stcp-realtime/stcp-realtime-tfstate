# ---------------------------------------------------------------------------------------------------------------------
# S3
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_s3_bucket" "s3_bucket" {
  #checkov:skip=CKV_AWS_18: Access logging not needed at this point
  #checkov:skip=CKV_AWS_21: Versioning not needed for now, will re-evaluate when using for Prod
  #checkov:skip=CKV2_AWS_61: Want to keep all locks right now, can add lifecycle later if needed
  #checkov:skip=CKV2_AWS_62: Events not needed for the locks s3
  #checkov:skip=CKV_AWS_144: For now it is overkill, will look into it later
  #checkov:skip=CKV_AWS_145: Encryption drives up costs, for the state files at least it isn't required
  bucket = "${var.project_name}-${var.environment}"
}

resource "aws_s3_bucket_public_access_block" "s3_bucket_public_access_block" {
  bucket = aws_s3_bucket.s3_bucket.id
  block_public_acls = true
  block_public_policy = true
  ignore_public_acls = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_ownership_controls" "s3_bucket_ownership" {
  bucket = aws_s3_bucket.s3_bucket.id
  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

resource "aws_s3_bucket_policy" "s3-bucket-policy-deny-http-requests" {
  bucket = aws_s3_bucket.s3_bucket.id
  policy =  jsonencode({
    "Version": "2012-10-17",
    "Statement":[{
      "Effect": "Deny",
      "Action": "s3:*",
      "Principal": "*",
      "Resource": "${aws_s3_bucket.s3_bucket.arn}/*",
      "Condition": {
        "Bool": {
          "aws:SecureTransport": "false"
        }
      }
    }]
  })
}
