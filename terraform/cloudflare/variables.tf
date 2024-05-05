variable "CF_API_TOKEN" {
  type        = string
  description = "Cloudflare API Token"
  sensitive   = true
  nullable    = false
}

variable "CF_HIBARE_ZONE_ID" {
  type        = string
  description = "Cloudflare Hibare Zone ID"
  sensitive   = false
  nullable    = false
}

variable "CF_XYZ_ZONE_ID" {
  type        = string
  description = "Cloudflare XYZ Zone ID"
  sensitive   = false
  nullable    = false
}
