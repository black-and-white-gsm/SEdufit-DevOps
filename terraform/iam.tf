resource "aws_iam_role" "kakao_chatbot_lambda_role" {
  name = "KakaoChatbotLambdaRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_policy" "kakao_chatbot_iam_policy" {
  name        = "KakaoChatbotIamPolicy"
  description = "IAM policy for Kakao Chatbot Lambda function"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "lambda:InvokeFunction",
          "lambda:InvokeAsync"
        ]
        Resource = "*"
      },
      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "kakao_chatbot_policy_attachment" {
  role       = aws_iam_role.kakao_chatbot_lambda_role.name
  policy_arn = aws_iam_policy.kakao_chatbot_iam_policy.arn
}
