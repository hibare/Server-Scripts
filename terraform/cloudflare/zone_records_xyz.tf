resource "cloudflare_record" "a_xyz" {
  zone_id = var.CF_XYZ_ZONE_ID
  name    = "09876543.xyz"
  value   = "95.216.147.137"
  type    = "A"
  proxied = true
}

resource "cloudflare_record" "aaaa_xyz" {
  zone_id = var.CF_XYZ_ZONE_ID
  name    = "09876543.xyz"
  value   = "2a01:4f9:c011:4672::1"
  type    = "AAAA"
  proxied = true
}

resource "cloudflare_record" "cname_xyz_hook" {
  zone_id = var.CF_XYZ_ZONE_ID
  name    = "hook"
  value   = "09876543.xyz"
  type    = "CNAME"
  proxied = true
}

resource "cloudflare_record" "cname_xyz_ip" {
  zone_id = var.CF_XYZ_ZONE_ID
  name    = "ip"
  value   = "09876543.xyz"
  type    = "CNAME"
  proxied = true
}

resource "cloudflare_record" "cname_xyz_www" {
  zone_id = var.CF_XYZ_ZONE_ID
  name    = "www"
  value   = "09876543.xyz"
  type    = "CNAME"
  proxied = true
}

# MX records are managed by cloudflare
# resource "cloudflare_record" "mx_xyz_1" {
#   zone_id = var.CF_XYZ_ZONE_ID
#   name    = "09876543.xyz"
#   value   = "route1.mx.cloudflare.net"
#   type    = "MX"
# }

# resource "cloudflare_record" "mx_xyz_2" {
#   zone_id = var.CF_XYZ_ZONE_ID
#   name    = "09876543.xyz"
#   value   = "route2.mx.cloudflare.net"
#   type    = "MX"
# }

# resource "cloudflare_record" "mx_xyz_3" {
#   zone_id = var.CF_XYZ_ZONE_ID
#   name    = "09876543.xyz"
#   value   = "route3.mx.cloudflare.net"
#   type    = "MX"
# }

resource "cloudflare_record" "txt_xyz_spf" {
  zone_id = var.CF_XYZ_ZONE_ID
  name    = "09876543.xyz"
  value   = "v=spf1 include:_spf.mx.cloudflare.net ~all"
  type    = "TXT"
}

