resource "cloudflare_zone" "xyz-09876543" {
  account = {
    id = var.CF_ACCOUNT_ID
  }
  type       = "full"
  name = "09876543.xyz"
}

resource "cloudflare_zone" "in-hibare" {
  account = {
    id = var.CF_ACCOUNT_ID
  }
  type       = "full"
  name = "hibare.in"
}
