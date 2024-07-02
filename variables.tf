variable "collection_name" {
  description = "Sets collection name in bedrock module"
  type        = string
  default     = ""
}

variable "deploy_opensearch_serverless_policies" {
  description = "Set to true to deploy the opensearch module"
  type        = bool
  default     = true
}

variable "deploy_bedrock" {
  description = "Set to true to deploy the bedrock module"
  type        = bool
  default     = true
}

variable "deploy_bedrock_datasource" {
  description = "Set to true to deploy the bedrock-datasource module"
  type        = bool
  default     = true
}