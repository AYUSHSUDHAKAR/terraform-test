data "aws_caller_identity" "current" {}

resource "aws_opensearchserverless_collection" "dolphin-collection" {
  name ="${var.collection_name}"
  type = "VECTORSEARCH"
}

resource "aws_bedrockagent_knowledge_base" "dolphin-kb" {
  name     = "dolphin-kb-ayush"
  role_arn = data.aws_caller_identity.current.arn
  knowledge_base_configuration {
    vector_knowledge_base_configuration {
      embedding_model_arn = "arn:aws:bedrock:us-west-2::foundation-model/amazon.titan-embed-g1-text-02"
    }
    type = "VECTOR"
  }
  storage_configuration {
    type = "OPENSEARCH_SERVERLESS"
    opensearch_serverless_configuration {
      collection_arn    = aws_opensearchserverless_collection.dolphin-collection.arn
      vector_index_name = "bedrock-knowledge-base-default-index"
      field_mapping {
        vector_field   = "bedrock-knowledge-base-default-vector"
        text_field     = "AMAZON_BEDROCK_TEXT_CHUNK"
        metadata_field = "AMAZON_BEDROCK_METADATA"
      }
    }
  }

  depends_on = [aws_opensearchserverless_collection.dolphin-collection]
}

output "kb_id" {
  value = aws_bedrockagent_knowledge_base.dolphin-kb.id
}