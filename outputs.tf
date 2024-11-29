output "chatbot_lambda_arn" {
  description = "Kakao Chatbot Function ARN"
  value       = aws_lambda_function.chatbot_lambda.arn
}

output "chatbot_lambda_role_arn" {
  description = "IAM Role for Kakao Chatbot Function"
  value       = aws_iam_role.chatbot_lambda_role.arn
}

output "callback_lambda_arn" {
  description = "Kakao Chatbot Callback Function ARN"
  value       = aws_lambda_function.callback_lambda.arn
}

output "callback_lambda_role_arn" {
  description = "IAM Role for Kakao Chatbot Callback Function"
  value       = aws_iam_role.callback_lambda_role.arn
}