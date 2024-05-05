resource "cloudflare_firewall_rule" "firewall_rule_hibare_ru" {
  action      = "block"
  description = "Russia"
  filter_id   = cloudflare_filter.filter_hibare_ru.id
  paused      = false
  zone_id     = cloudflare_zone.in-hibare.id
}

resource "cloudflare_firewall_rule" "firewall_rule_hibare_cn" {
  action      = "block"
  description = "China"
  filter_id   = cloudflare_filter.filter_hibare_cn.id
  paused      = false
  zone_id     = cloudflare_zone.in-hibare.id
}
