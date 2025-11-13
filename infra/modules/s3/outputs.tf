output bucket_arn {
  value       = aws_s3_bucket.this.arn
  sensitive   = true
  description = "arn of the s3 bucket"
}
