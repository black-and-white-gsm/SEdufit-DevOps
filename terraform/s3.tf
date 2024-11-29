resource "aws_s3_bucket" "lambda_code_bucket" {
  bucket = "lambda-code-bucket-SEdufit"  # 고유한 버킷 이름으로 변경하세요.
  // acl    = "private"
}

resource "aws_s3_bucket_policy" "lambda_code_bucket_policy" {
  bucket = aws_s3_bucket.lambda_code_bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "AllowLambdaServiceToGetObject"
        Effect    = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.lambda_code_bucket.arn}/*"
      }
    ]
  })
}
