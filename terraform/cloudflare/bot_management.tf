# Bots disabled until we figure out how to bypass monitors
resource "cloudflare_bot_management" "bot_management_hibare_in" {
  zone_id = cloudflare_zone.in-hibare.id
  ai_bots_protection = "disabled"
  enable_js = true
  fight_mode = false
}

resource "cloudflare_bot_management" "bot_management_xyz" {
  zone_id = cloudflare_zone.xyz-09876543.id
  ai_bots_protection = "disabled"
  enable_js = true
  fight_mode = false
}