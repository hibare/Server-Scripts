resource "cloudflare_zone_setting" "zone_settings_hibare_in_always_online" {
  zone_id    = cloudflare_zone.in-hibare.id
  setting_id = "always_online"
  value      = "on"
}

resource "cloudflare_zone_setting" "zone_settings_hibare_in_always_use_https" {
  zone_id    = cloudflare_zone.in-hibare.id
  setting_id = "always_use_https"
  value      = "on"
}

resource "cloudflare_zone_setting" "zone_settings_hibare_in_always_automatic_https_rewrites" {
  zone_id    = cloudflare_zone.in-hibare.id
  setting_id = "automatic_https_rewrites"
  value      = "on"
}

resource "cloudflare_zone_setting" "zone_settings_hibare_in_brotli" {
  zone_id    = cloudflare_zone.in-hibare.id
  setting_id = "brotli"
  value      = "on"
}

resource "cloudflare_zone_setting" "zone_settings_hibare_in_browser_cache_ttl" {
  zone_id    = cloudflare_zone.in-hibare.id
  setting_id = "browser_cache_ttl"
  value      = 86400
}

resource "cloudflare_zone_setting" "zone_settings_hibare_in_browser_check" {
  zone_id    = cloudflare_zone.in-hibare.id
  setting_id = "browser_check"
  value      = "on"
}

resource "cloudflare_zone_setting" "zone_settings_hibare_in_cache_level" {
  zone_id    = cloudflare_zone.in-hibare.id
  setting_id = "cache_level"
  value      = "aggressive"
}

resource "cloudflare_zone_setting" "zone_settings_hibare_in_challenge_ttl" {
  zone_id    = cloudflare_zone.in-hibare.id
  setting_id = "challenge_ttl"
  value      = "1800"
}

resource "cloudflare_zone_setting" "zone_settings_hibare_in_cname_flattening" {
  zone_id    = cloudflare_zone.in-hibare.id
  setting_id = "cname_flattening"
  value      = "flatten_at_root"
}

resource "cloudflare_zone_setting" "zone_settings_hibare_in_development_mode" {
  zone_id    = cloudflare_zone.in-hibare.id
  setting_id = "development_mode"
  value      = "off"
}

resource "cloudflare_zone_setting" "zone_settings_hibare_in_early_hints" {
  zone_id    = cloudflare_zone.in-hibare.id
  setting_id = "early_hints"
  value      = "on"
}

resource "cloudflare_zone_setting" "zone_settings_hibare_in_email_obfuscation" {
  zone_id    = cloudflare_zone.in-hibare.id
  setting_id = "email_obfuscation"
  value      = "on"
}

resource "cloudflare_zone_setting" "zone_settings_hibare_in_hotlink_protection" {
  zone_id    = cloudflare_zone.in-hibare.id
  setting_id = "hotlink_protection"
  value      = "on"
}

resource "cloudflare_zone_setting" "zone_settings_hibare_in_http3" {
  zone_id    = cloudflare_zone.in-hibare.id
  setting_id = "http3"
  value      = "on"
}

resource "cloudflare_zone_setting" "zone_settings_hibare_in_ip_geolocation" {
  zone_id    = cloudflare_zone.in-hibare.id
  setting_id = "ip_geolocation"
  value      = "on"
}

resource "cloudflare_zone_setting" "zone_settings_hibare_in_ipv6" {
  zone_id    = cloudflare_zone.in-hibare.id
  setting_id = "ipv6"
  value      = "on"
}

resource "cloudflare_zone_setting" "zone_settings_hibare_in_max_upload" {
  zone_id    = cloudflare_zone.in-hibare.id
  setting_id = "max_upload"
  value      = "100"
}

resource "cloudflare_zone_setting" "zone_settings_hibare_in_min_tls_version" {
  zone_id    = cloudflare_zone.in-hibare.id
  setting_id = "min_tls_version"
  value      = "1.0"
}

resource "cloudflare_zone_setting" "zone_settings_hibare_in_opportunistic_encryption" {
  zone_id    = cloudflare_zone.in-hibare.id
  setting_id = "opportunistic_encryption"
  value      = "on"
}

resource "cloudflare_zone_setting" "zone_settings_hibare_in_opportunistic_onion" {
  zone_id    = cloudflare_zone.in-hibare.id
  setting_id = "opportunistic_onion"
  value      = "on"
}

resource "cloudflare_zone_setting" "zone_settings_hibare_in_security_level" {
  zone_id    = cloudflare_zone.in-hibare.id
  setting_id = "security_level"
  value      = "medium"
}

resource "cloudflare_zone_setting" "zone_settings_hibare_in_server_side_exclude" {
  zone_id    = cloudflare_zone.in-hibare.id
  setting_id = "server_side_exclude"
  value      = "on"
}

resource "cloudflare_zone_setting" "zone_settings_hibare_in_ssl" {
  zone_id    = cloudflare_zone.in-hibare.id
  setting_id = "ssl"
  value      = "full"
}

resource "cloudflare_zone_setting" "zone_settings_hibare_in_tls_1_3" {
  zone_id    = cloudflare_zone.in-hibare.id
  setting_id = "tls_1_3"
  value      = "on"
}

resource "cloudflare_zone_setting" "zone_settings_hibare_in_websockets" {
  zone_id    = cloudflare_zone.in-hibare.id
  setting_id = "websockets"
  value      = "on"
}
