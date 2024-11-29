resource "aws_lambda_function" "chatbot_lambda" {
  filename      = "./src/app.zip"
  function_name = "chatbot-lambda"
  role          = aws_iam_role.chatbot_lambda_role.arn
  handler       = "app.lambda_handler"
  runtime       = "python3.12"
  timeout       = 480
  memory_size   = 1024

  environment {
    variables = {
      CALLBACK_LAMBDA_FUNCTION_NAME = aws_lambda_function.callback_lambda.function_name
      TEXT_TO_IMAGE_S3_BUCKET_NAME  = aws_s3_bucket.text_to_image.id
      AWS_REGION_NAME               = var.aws_region
    }
  }
}

resource "aws_lambda_function" "callback_lambda" {
  filename      = "./src/callback.zip"
  function_name = "callback-lambda"
  role          = aws_iam_role.callback_lambda_role.arn
  handler       = "callback.lambda_handler"
  runtime       = "python3.12"
  timeout       = 480
  memory_size   = 1024
  layers        = [aws_lambda_layer_version.lambda_layer.arn]

  environment {
    variables = {
      CALLBACK_LAMBDA_FUNCTION_NAME = aws_lambda_function.callback_lambda.function_name
      TEXT_TO_IMAGE_S3_BUCKET_NAME  = aws_s3_bucket.text_to_image.id
      AWS_REGION_NAME               = var.aws_region
    }
  }
}

resource "aws_lambda_layer_version" "lambda_layer" {
  filename   = "./layer.zip"
  layer_name = "LambdaLayer"

  compatible_runtimes = ["python3.12"]
}