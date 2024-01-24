output "api_gateway_url" {
  description = "API Gateway URL"
  value = module.api_gateway.base_url_api_gw_stage_dev
}

output "cognito_user_pool_id" {
  description = "Cognito User Pool ID"
  value = module.cognito.cognito_user_pool_id
}

output "cognito_client_id" {
  description = "Cognito Client ID"
  value = module.cognito.client_id
}

output "cognito_client_name" {
  description = "Cognito Client Name"
  value = module.cognito.client_name
}

output "cluster_eks_name" {
  description = "Cluster EKS Name"
  value = module.eks.cluster_eks_name
}

output "cluster_eks_vpc_link" {
  description = "VPC Link EKS ID"

  value = module.eks.vpc_link
}

output "cluster_eks_private_subnet_one" {
  description = "EKS Private Subnet ID"

  value = module.eks.private_subnet_one
}

output "cluster_eks_private_subnet_two" {
  description = "EKS Private Subnet ID"

  value = module.eks.private_subnet_two
}

output "aws_apigatewayv2_api_restrict_api_id" {
  description = "API Gateway Restrict API ID"

  value = module.api_gateway.aws_apigatewayv2_api_restrict_api_id
}

output "aws_apigatewayv2_authorizer_authorizer_id" {
  description = "API Gateway Autorizer ID"

  value = module.api_gateway.aws_apigatewayv2_authorizer_authorizer_id
}

output "aws_apigatewayv2_vpc_link_eks_id" {
  description = "API Gateway VPC Link ID"

  value = module.api_gateway.aws_apigatewayv2_vpc_link_eks_id
}


############################################### [RDS] Outputs

output "security_group_id" {
  value = module.rds.security_group_id
}
output "db_instance_endpoint" {
  value = module.rds.db_instance_endpoint
}

###############################################
