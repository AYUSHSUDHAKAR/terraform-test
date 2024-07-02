data "aws_caller_identity" "current" {}

resource "aws_opensearchserverless_security_policy" "dolphin-policy-encryption" {
  name        = "dolphin-policy"
  type        = "encryption"
  description = "encryption security policy for collections that begin with \"dolpin-collection\""
  policy = jsonencode({
    Rules = [
      {
        Resource = [
          "collection/dolphin-collection*"
        ],
        ResourceType = "collection"
      }
    ],
    AWSOwnedKey = true
  })
}

resource "aws_opensearchserverless_security_policy" "dolphin-policy-network" {
  name        = "dolphin-policy"
  type        = "network"
  description = "Public access"
  policy = jsonencode([
    {
      Description = "Public access to collection and Dashboards endpoint for dolphin collection",
      Rules = [
        {
          ResourceType = "collection",
          Resource = [
            "collection/dolphin-collection*"
          ]
        },
        {
          ResourceType = "dashboard"
          Resource = [
            "collection/dolphin-collection*"
          ]
        }
      ],
      AllowFromPublic = true
    }
  ])
}

resource "aws_opensearchserverless_access_policy" "dolphin-policy-access" {
  name        = "dolphin-policy"
  type        = "data"
  description = "read and write permissions"
  policy = jsonencode([
    {
      Rules = [
        {
          ResourceType = "index",
          Resource = [
            "index/dolphin-collection*/*"
          ],
          Permission = [
            "aoss:*"
          ]
        },
        {
          ResourceType = "collection",
          Resource = [
            "collection/dolphin-collection*"
          ],
          Permission = [
            "aoss:*"
          ]
        }
      ],
      Principal = [
        data.aws_caller_identity.current.arn
      ]
    }
  ])
}