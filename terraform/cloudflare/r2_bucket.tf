resource "cloudflare_r2_bucket" "terraform_state" {
  account_id = var.CF_ACCOUNT_ID
  name = "terraform-state"
  location = "APAC"
  storage_class = "Standard"
}
