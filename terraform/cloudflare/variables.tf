variable "CF_API_TOKEN" {
  type        = string
  description = "Cloudflare API Token"
  sensitive   = true
  nullable    = false
}

variable "CF_ACCOUNT_ID" {
  type        = string
  description = "Cloudflare Account ID"
  sensitive   = true
  nullable    = false
}

