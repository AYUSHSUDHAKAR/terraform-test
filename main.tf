
provider "aws" {
  region = "us-west-2"
}

module "opensearch-serverless-policies" {
  source = "./modules/opensearch-serverless-policies"
  count  = var.deploy_opensearch_serverless_policies ? 1 : 0
  # Pass variables to the module if needed
}

module "bedrock" {
  source = "./modules/bedrock"
  count  = var.deploy_bedrock ? 1 : 0
  # Pass variables to the module if needed
  collection_name = var.collection_name
  depends_on      = [module.opensearch-serverless-policies[0]]
}

module "bedrock-datasource" {
  source = "./modules/bedrock-datasource"
  count  = var.deploy_bedrock_datasource ? 1 : 0
  # Pass variables to the module if needed
  kb_id      = module.bedrock[0].kb_id
  depends_on = [module.bedrock[0]]
}

