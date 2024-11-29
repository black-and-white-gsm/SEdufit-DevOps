resource "aws_s3_bucket" "text_to_image" {
  bucket = "text-to-image-bucket-${random_string.bucket_suffix.result}"
}

resource "random_string" "bucket_suffix" {
  length  = 8
  special = false
  upper   = false
}

resource "aws_s3_bucket_public_access_block" "text_to_image" {
  bucket = aws_s3_bucket.text_to_image.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "text_to_image" {
  bucket = aws_s3_bucket.text_to_image.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.text_to_image.arn}/*"
      }
    ]
  })
}