resource "cloudflare_record" "a_hibare" {
  zone_id = cloudflare_zone.in-hibare.id
  name    = "hibare.in"
  value   = "95.216.147.137"
  type    = "A"
  proxied = true
}

resource "cloudflare_record" "aaaa_hibare" {
  zone_id = cloudflare_zone.in-hibare.id
  name    = "hibare.in"
  value   = "2a01:4f9:c011:4672::1"
  type    = "AAAA"
  proxied = true
}

resource "cloudflare_record" "a_hibare_int" {
  zone_id = cloudflare_zone.in-hibare.id
  name    = "*.int.hibare.in"
  value   = "10.2.0.101"
  type    = "A"
  proxied = false
}

resource "cloudflare_record" "cname_hibare_apt" {
  zone_id = cloudflare_zone.in-hibare.id
  name    = "apt"
  value   = "apt.hibare.in.furyns.com"
  type    = "CNAME"
  proxied = false
}

resource "cloudflare_record" "cname_hibare_yum" {
  zone_id = cloudflare_zone.in-hibare.id
  name    = "yum"
  value   = "yum.hibare.in.furyns.com"
  type    = "CNAME"
  proxied = false
}

resource "cloudflare_record" "cname_hibare_auth" {
  zone_id = cloudflare_zone.in-hibare.id
  name    = "auth"
  value   = "hibare.in"
  type    = "CNAME"
  proxied = true
}

resource "cloudflare_record" "cname_hibare_blog" {
  zone_id = cloudflare_zone.in-hibare.id
  name    = "blog"
  value   = "hibare.in"
  type    = "CNAME"
  proxied = true
}

resource "cloudflare_record" "cname_hibare_chat" {
  zone_id = cloudflare_zone.in-hibare.id
  name    = "chat"
  value   = "hibare.in"
  type    = "CNAME"
  proxied = true
}

resource "cloudflare_record" "cname_hibare_containers" {
  zone_id = cloudflare_zone.in-hibare.id
  name    = "containers"
  value   = "hibare.in"
  type    = "CNAME"
  proxied = true
}

resource "cloudflare_record" "cname_hibare_dash" {
  zone_id = cloudflare_zone.in-hibare.id
  name    = "dash"
  value   = "hibare.in"
  type    = "CNAME"
  proxied = true
}

resource "cloudflare_record" "cname_hibare_safe" {
  zone_id = cloudflare_zone.in-hibare.id
  name    = "safe"
  value   = "hibare.in"
  type    = "CNAME"
  proxied = true
}

resource "cloudflare_record" "cname_hibare_scale" {
  zone_id = cloudflare_zone.in-hibare.id
  name    = "scale"
  value   = "hibare.in"
  type    = "CNAME"
  proxied = false
}

resource "cloudflare_record" "cname_hibare_send" {
  zone_id = cloudflare_zone.in-hibare.id
  name    = "send"
  value   = "hibare.in"
  type    = "CNAME"
  proxied = true
}

resource "cloudflare_record" "cname_hibare_test" {
  zone_id = cloudflare_zone.in-hibare.id
  name    = "test"
  value   = "hibare.in"
  type    = "CNAME"
  proxied = true
}

resource "cloudflare_record" "cname_hibare_tools" {
  zone_id = cloudflare_zone.in-hibare.id
  name    = "tools"
  value   = "hibare.in"
  type    = "CNAME"
  proxied = true
}

resource "cloudflare_record" "cname_hibare_web_chat" {
  zone_id = cloudflare_zone.in-hibare.id
  name    = "web-chat"
  value   = "hibare.in"
  type    = "CNAME"
  proxied = true
}

resource "cloudflare_record" "cname_hibare_www" {
  zone_id = cloudflare_zone.in-hibare.id
  name    = "www"
  value   = "hibare.in"
  type    = "CNAME"
  proxied = true
}

resource "cloudflare_record" "cname_hibare_github" {
  zone_id = cloudflare_zone.in-hibare.id
  name    = "github"
  value   = "hibare.github.io"
  type    = "CNAME"
  proxied = false
}

resource "cloudflare_record" "cname_hibare_mail" {
  zone_id = cloudflare_zone.in-hibare.id
  name    = "mail"
  value   = "business.zoho.com"
  type    = "CNAME"
  proxied = false
}

resource "cloudflare_record" "cname_hibare_moni" {
  zone_id = cloudflare_zone.in-hibare.id
  name    = "moni"
  value   = "moni-0jgm.onrender.com"
  type    = "CNAME"
  proxied = false
}

resource "cloudflare_record" "cname_hibare_sendgrid_1" {
  zone_id = cloudflare_zone.in-hibare.id
  name    = "36250734"
  value   = "sendgrid.net"
  type    = "CNAME"
  proxied = false
}

resource "cloudflare_record" "cname_hibare_sendgrid_2" {
  zone_id = cloudflare_zone.in-hibare.id
  name    = "em7012"
  value   = "u36250734.wl235.sendgrid.net"
  type    = "CNAME"
  proxied = false
}

resource "cloudflare_record" "cname_hibare_sendgrid_3" {
  zone_id = cloudflare_zone.in-hibare.id
  name    = "s1._domainkey"
  value   = "s1.domainkey.u36250734.wl235.sendgrid.net"
  type    = "CNAME"
  proxied = false
}


resource "cloudflare_record" "cname_hibare_sendgrid_4" {
  zone_id = cloudflare_zone.in-hibare.id
  name    = "s2._domainkey"
  value   = "s2.domainkey.u36250734.wl235.sendgrid.net"
  type    = "CNAME"
  proxied = false
}

resource "cloudflare_record" "cname_hibare_sendgrid_5" {
  zone_id = cloudflare_zone.in-hibare.id
  name    = "url9897"
  value   = "sendgrid.net"
  type    = "CNAME"
  proxied = false
}

resource "cloudflare_record" "mx_hibare_1" {
  zone_id  = cloudflare_zone.in-hibare.id
  name     = "hibare.in."
  value    = "mx.zoho.com"
  type     = "MX"
  proxied  = false
  priority = 10
}

resource "cloudflare_record" "mx_hibare_2" {
  zone_id  = cloudflare_zone.in-hibare.id
  name     = "hibare.in."
  value    = "mx2.zoho.com"
  type     = "MX"
  proxied  = false
  priority = 20
}

resource "cloudflare_record" "mx_hibare_3" {
  zone_id  = cloudflare_zone.in-hibare.id
  name     = "hibare.in."
  value    = "mx3.zoho.com"
  type     = "MX"
  proxied  = false
  priority = 30
}

resource "cloudflare_record" "txt_hibare_dkim" {
  zone_id = cloudflare_zone.in-hibare.id
  name    = "dkim._domainkey"
  value   = "v=DKIM1; k=rsa; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCcuavpbZiToTfTOjfRbuBcSUOK1woYQ1jyXG/PQm4KX8KwJFmRl6eZzr5f7vqiYKbDSUCTPDNU/jaF9mMTvd9s90BLX9DtLytCOiMtf+aE9PU1tkz/HnQpToWq8SIqbKpKw5B4SDlToNf70vK4WBE1VL2HbQyFpcP7/+BiNywJWwIDAQAB"
  type    = "TXT"
  proxied = false
}

resource "cloudflare_record" "txt_hibare_dmarc" {
  zone_id = cloudflare_zone.in-hibare.id
  name    = "_dmarc"
  value   = "v=DMARC1; p=quarantine; rua=mailto:admin@hibare.in; ruf=mailto:admin@hibare.in"
  type    = "TXT"
  proxied = false
}

resource "cloudflare_record" "txt_hibare_gh_pages_challenge" {
  zone_id = cloudflare_zone.in-hibare.id
  name    = "_github-pages-challenge-hibare"
  value   = "66c09cea64f38316d30d3c5f3de784"
  type    = "TXT"
  proxied = false
}

resource "cloudflare_record" "txt_hibare_haveibeenpwned" {
  zone_id = cloudflare_zone.in-hibare.id
  name    = "hibare.in"
  value   = "have-i-been-pwned-verification=af25af8ac9d9e7e85213613701c46156"
  type    = "TXT"
  proxied = false
}

resource "cloudflare_record" "txt_hibare_spf" {
  zone_id = cloudflare_zone.in-hibare.id
  name    = "hibare.in"
  value   = "v=spf1 include:zoho.com ~all"
  type    = "TXT"
  proxied = false
}

resource "cloudflare_record" "txt_hibare_zoho_verification" {
  zone_id = cloudflare_zone.in-hibare.id
  name    = "hibare.in"
  value   = "zoho-verification=zb15299188.zmverify.zoho.com"
  type    = "TXT"
  proxied = false
}

