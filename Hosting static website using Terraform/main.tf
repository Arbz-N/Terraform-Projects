# Generate a random ID
resource "random_id" "random_id" {
  byte_length = var.length_for_random_id
}

locals {
  S3_bucket_name = "s3-static-website-${random_id.random_id.hex}"
}

resource "aws_s3_bucket" "static_web_bucket" {
  bucket = local.S3_bucket_name
}

resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.static_web_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "policy_for_bucket" {
  bucket = aws_s3_bucket.static_web_bucket.id
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "arn:aws:s3:::${aws_s3_bucket.static_web_bucket.id}/*"
      }
    ]
  })
}

resource "aws_s3_bucket_website_configuration" "config_for_bucket" {
  bucket = aws_s3_bucket.static_web_bucket.id

  index_document {
    suffix = "index.html"
  }
}

resource "aws_s3_object" "index_html" {
  bucket       = aws_s3_bucket.static_web_bucket.bucket
  key          = "index.html"
  source       = "<LOCAL_INDEX_HTML>"  # Example: ./index.html
  content_type = "text/html"
}

resource "aws_s3_object" "styles_css" {
  bucket       = aws_s3_bucket.static_web_bucket.bucket
  key          = "styles.css"
  source       = "<LOCAL_CSS_FILE>"    # Example: ./styles.css
  content_type = "text/css"
}




