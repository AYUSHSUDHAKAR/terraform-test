resource "aws_bedrockagent_data_source" "dolphin-datasource" {
  knowledge_base_id = var.kb_id
  name              = "dolphin-datasource-ayush-01"
  data_source_configuration {
    type = "S3"
    s3_configuration {
      bucket_arn = "arn:aws:s3:::dolphin-bucket-ayush"
    }
  }
}
