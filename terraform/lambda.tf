resource "aws_lambda_function" "kakao_chatbot_lambda" {
  function_name = "chatbot-lambda"
  handler       = "app.lambda_handler"
  runtime       = "python3.13"
  role          = aws_iam_role.kakao_chatbot_lambda_role.arn
  filename      = "src.zip"  # Ensure you have the source code zipped

  environment {
    variables = {
      CALLBACK_LAMBDA_FUNCTION_NAME = "callback-lambda"
      TEXT_TO_IMAGE_S3_BUCKET_NAME  = aws_s3_bucket.text_to_image_s3_bucket.bucket
      AWS_REGION_NAME               = var.aws_region
    }
  }
}

resource "aws_lambda_permission" "api_gateway_permission" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.kakao_chatbot_lambda.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.api_gateway.execution_arn}/*/*"
}
