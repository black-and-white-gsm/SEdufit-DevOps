resource "aws_api_gateway_rest_api" "api_gateway" {
  name        = "KakaoChatbotAPI"
  description = "API Gateway for Kakao Chatbot"
}

resource "aws_api_gateway_stage" "api_gateway_stage" {
  stage_name    = "v1"
  rest_api_id   = aws_api_gateway_rest_api.api_gateway.id
  deployment_id = aws_api_gateway_deployment.api_gateway_deployment.id
}

resource "aws_api_gateway_deployment" "api_gateway_deployment" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  triggers = {
    redeployment = sha1(file("src.zip"))  # Trigger redeployment on code change
  }
}