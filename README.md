# STCP Realtime Tfstate

STCP Realtime Tfstate has terraform IaC to deploy a S3 Bucket and a DynamoDB table in AWS.

Terraform will then use these S3 Buckets for storing the tfstate files and the DynamoDB table for centralized locking.