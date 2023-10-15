provider "aws" {
  region  = var.region
  profile = var.profile
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.20.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.1.0"
    }
    archive = {
      source  = "hashicorp/archive"
      version = "~> 2.2.0"
    }
  }
}

module "cognito" {
  ############################################### [TAGs] Variables
  application_name = var.application_name
  environment      = var.environment
  owner_team       = var.owner_team
  ############################################### [Cognito] Variables
  source                  = "../totem-food-service-tf-module-cognito"
  user_pool_name          = "user-pool"
  user_pool_domain        = "totem-food"
  refresh_token_validity  = 90
  refresh_token_unit      = "days"
  access_token_validity   = 5
  access_token_unit       = "minutes"
  id_token_validity       = 5
  id_token_unit           = "minutes"
  client_name             = "cognito-client"
  callback_urls           = ["https://example.com", "https://oauth.pstmn.io/v1/callback"]
  ############################################### [Cognito] Variables - Anonymous User
  anonymous_user_username = "anonymous"
  anonymous_user_password = "anonymous"
  anonymous_user_cpf = "11111111111"
  anonymous_user_email = "no-reply@email.com"
}

module "authorizer" {
  source = "../totem-food-service-tf-module-authorizer"

  ############################################### [TAGs] Variables
  application_name = var.application_name
  environment      = var.environment
  owner_team       = var.owner_team
  ############################################### [Cognito] Variables
  cognito_client_id    = module.cognito.client_id
  cognito_user_pool_id = module.cognito.cognito_user_pool_id
}

module "login" {
  source = "../totem-food-service-tf-module-login"

  ############################################### [TAGs] Variables
  application_name = var.application_name
  environment      = var.environment
  owner_team       = var.owner_team
  ############################################### [Cognito] Variables
  cognito_client_id          = module.cognito.client_id
  cognito_client_secret      = module.cognito.client_secret
  cognito_anonymous_user     = module.cognito.cognito_anonymous_user
  cognito_anonymous_password = module.cognito.cognito_anonymous_user_password
}

module "eks" {
  source = "../totem-food-service-tf-module-eks"

  ############################################### [TAGs] Variables
  application_name = var.application_name
  environment      = var.environment
  owner_team       = var.owner_team
  ############################################### [IGW] Variables
  internet_gateway_tag_name = format("%s-igw", var.application_name)
  ############################################### [EKS] Variables
  cluster_eks_name                 = format("%s", var.application_name)
  cluster_policy_eks_iam_role_name = format("%s-iam-role", var.application_name)
  ############################################### [EKS Subnets] Variables
  eks_private_subnet_one_availability_zone = "us-east-1a"
  eks_private_subnet_two_availability_zone = "us-east-1b"
  eks_public_subnet_one_availability_zone  = "us-east-1a"
  eks_public_subnet_two_availability_zone  = "us-east-1b"
  ############################################### [EKS Nodes] Variables
  eks_iam_role_name_for_nodes_groups     = format("%s-iam-node-groups", var.application_name)
  eks_private_node_group_name            = format("%s-private-node-groups", var.application_name)
  eks_node_capacity_types                = "SPOT"
  eks_node_instance_types                = ["t3.small"]
  eks_node_scaling_config_min_size       = 2
  eks_node_scaling_config_max_size       = 4
  eks_node_scaling_config_desized_size   = 2
  eks_node_update_config_max_unavailable = 1
}

module "api_gateway" {
  source = "../totem-food-service-tf-module-api-gateway"

  ############################################### [TAGs] Variables
  application_name = var.application_name
  environment      = var.environment
  owner_team       = var.owner_team
  ############################################### [Lambda][Autorizer] Variables
  lambda_authorizer_invoke_arn = module.authorizer.function_authorizer_invoke_arn
  lambda_authorizer_name       = module.authorizer.function_authorizer_name

  ############################################### [Lambda][Login] Variables
  lambda_login_invoke_arn = module.login.function_login_invoke_arn
  lambda_login_name       = module.login.function_login_name

  ############################################### [EKS] Variables
  vpc_security_group_eks_ids = [module.eks.vpc_link]
  eks_private_subnet_ids     = [module.eks.private_subnet_one, module.eks.private_subnet_two]

}

