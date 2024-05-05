resource "cloudflare_zone_settings_override" "zone_settings_hibare_in" {
  zone_id = cloudflare_zone.in-hibare.id
  settings {
    always_online            = "off"
    always_use_https         = "off"
    automatic_https_rewrites = "on"
    brotli                   = "on"
    browser_cache_ttl        = 86400
    browser_check            = "on"
    cache_level              = "aggressive"
    challenge_ttl            = 1800
    cname_flattening         = "flatten_at_root"
    development_mode         = "off"
    early_hints              = "off"
    email_obfuscation        = "on"
    hotlink_protection       = "on"
    http3                    = "on"
    ip_geolocation           = "on"
    ipv6                     = "on"
    max_upload               = 100
    min_tls_version          = "1.0"
    minify {
      css  = "on"
      html = "on"
      js   = "on"
    }
    opportunistic_encryption = "on"
    opportunistic_onion      = "on"
    privacy_pass             = "on"
    security_header {
      enabled            = true
      include_subdomains = true
      max_age            = 0
      nosniff            = false
      preload            = false
    }
    security_level      = "medium"
    server_side_exclude = "on"
    ssl                 = "full"
    tls_1_3             = "on"
    websockets          = "on"
  }
}


resource "cloudflare_zone_settings_override" "zone_settings_xyz" {
  zone_id = cloudflare_zone.xyz-09876543.id
  settings {
    always_online            = "off"
    always_use_https         = "off"
    automatic_https_rewrites = "on"
    brotli                   = "on"
    browser_cache_ttl        = 86400
    browser_check            = "on"
    cache_level              = "aggressive"
    challenge_ttl            = 1800
    cname_flattening         = "flatten_at_root"
    development_mode         = "off"
    early_hints              = "off"
    email_obfuscation        = "on"
    hotlink_protection       = "on"
    http3                    = "on"
    ip_geolocation           = "on"
    ipv6                     = "on"
    max_upload               = 100
    min_tls_version          = "1.0"
    minify {
      css  = "on"
      html = "on"
      js   = "on"
    }
    opportunistic_encryption = "on"
    opportunistic_onion      = "on"
    privacy_pass             = "on"
    security_header {
      enabled            = true
      include_subdomains = true
      max_age            = 0
      nosniff            = false
      preload            = false
    }
    security_level      = "medium"
    server_side_exclude = "on"
    ssl                 = "full"
    tls_1_3             = "on"
    websockets          = "on"
  }
}
