resource "cloudflare_filter" "filter_hibare_cn" {
  expression = "(ip.geoip.country eq \"CN\")"
  paused     = false
  zone_id    = cloudflare_zone.in-hibare.id
}

resource "cloudflare_filter" "filter_hibare_ru" {
  expression = "(ip.geoip.country eq \"RU\")"
  paused     = false
  zone_id    = cloudflare_zone.in-hibare.id
}
