output "website_static_link" {
  value = aws_s3_bucket_website_configuration.config_for_bucket.website_endpoint
}