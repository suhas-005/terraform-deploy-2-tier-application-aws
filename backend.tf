terraform {
  backend "s3" {
    bucket = "your-bucket-name"
    key    = "your-subpath/terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "your-dynamo-db-name"
  }
}