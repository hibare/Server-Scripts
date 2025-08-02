resource "cloudflare_dns_record" "a_xyz" {
  zone_id = cloudflare_zone.xyz-09876543.id
  name    = "09876543.xyz"
  content = "95.216.147.137"
  type    = "A"
  proxied = true
  ttl     = 1
}

resource "cloudflare_dns_record" "aaaa_xyz" {
  zone_id = cloudflare_zone.xyz-09876543.id
  name    = "09876543.xyz"
  content = "2a01:4f9:c011:4672::1"
  type    = "AAAA"
  proxied = true
  ttl     = 1
}

resource "cloudflare_dns_record" "cname_xyz_hook" {
  zone_id = cloudflare_zone.xyz-09876543.id
  name    = "hook"
  content = "09876543.xyz"
  type    = "CNAME"
  proxied = true
  ttl     = 1
}

resource "cloudflare_dns_record" "cname_xyz_ip" {
  zone_id = cloudflare_zone.xyz-09876543.id
  name    = "ip"
  content = "09876543.xyz"
  type    = "CNAME"
  proxied = true
  ttl     = 1
}

resource "cloudflare_dns_record" "cname_xyz_www" {
  zone_id = cloudflare_zone.xyz-09876543.id
  name    = "www"
  content = "09876543.xyz"
  type    = "CNAME"
  proxied = true
  ttl     = 1
}


# MX records are managed by cloudflare
# resource "cloudflare_dns_record" "mx_xyz_1" {
#   zone_id = cloudflare_zone.xyz-09876543.id
#   name    = "09876543.xyz"
#   content   = "route1.mx.cloudflare.net"
#   type    = "MX"
#   ttl = 1
# }

# resource "cloudflare_dns_record" "mx_xyz_2" {
#   zone_id = cloudflare_zone.xyz-09876543.id
#   name    = "09876543.xyz"
#   content   = "route2.mx.cloudflare.net"
#   type    = "MX"
#   ttl = 1
# }

# resource "cloudflare_dns_record" "mx_xyz_3" {
#   zone_id = cloudflare_zone.xyz-09876543.id
#   name    = "09876543.xyz"
#   content   = "route3.mx.cloudflare.net"
#   type    = "MX"
#   ttl = 1
# }

# resource "cloudflare_dns_record" "txt_xyz_spf" {
#   zone_id = cloudflare_zone.xyz-09876543.id
#   name    = "09876543.xyz"
#   content   = "v=spf1 include:_spf.mx.cloudflare.net ~all"
#   type    = "TXT"
#   ttl = 1
# }
