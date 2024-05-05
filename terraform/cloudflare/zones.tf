resource "cloudflare_zone" "xyz-09876543" {
  account_id = "cad602f826f70d10a39804c63c2ba6db"
  paused     = false
  plan       = "free"
  type       = "full"
  zone       = "09876543.xyz"
}

resource "cloudflare_zone" "in-hibare" {
  account_id = "cad602f826f70d10a39804c63c2ba6db"
  paused     = false
  plan       = "free"
  type       = "full"
  zone       = "hibare.in"
}
