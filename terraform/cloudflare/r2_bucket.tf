resource "cloudflare_r2_bucket" "terraform_state" {
  account_id = var.CF_ACCOUNT_ID
  name = "terraform-state"
  location = "apac"
  storage_class = "Standard"
}
