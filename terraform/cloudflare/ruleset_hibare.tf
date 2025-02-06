resource "cloudflare_ruleset" "ddos_hibare_in" {
  kind    = "zone"
  name    = "ddos_hibare_in"
  phase   = "ddos_l7"
  zone_id = cloudflare_zone.in-hibare.id
  rules =[ 
    {
      action      = "execute"
      description = "zone"
      enabled     = true
      expression  = "true"
      action_parameters = {
        id = "4d21379b4f9f4bb088e0729962c8b3cf"

        overrides ={
          action            = "challenge"
          sensitivity_level = "default"
        }
      }
    }
  ]
}

resource "cloudflare_ruleset" "firewall_custom_hibare_in" {
  kind    = "zone"
  name    = "firewall_custom_hibare_in"
  phase   = "http_request_firewall_custom"
  zone_id = cloudflare_zone.in-hibare.id
  rules =[ 
    {
      action      = "block"
      description = "Russia"
      enabled     = true
      expression  = "(ip.geoip.country eq \"RU\")"
    },
    {
      action      = "block"
      description = "China"
      enabled     = true
      expression  = "(ip.geoip.country eq \"CN\")"
    }
  ]
}

resource "cloudflare_ruleset" "header_transform_hibare_in" {
  kind    = "zone"
  name    = "header_transform_hibare_in"
  phase   = "http_request_late_transform"
  zone_id = cloudflare_zone.in-hibare.id
  rules =[ 
    {
      action = "rewrite"
      action_parameters = {
        headers = {
          x_forwarded_for = {
            operation = "remove"
          }
        }
      }
      description = "Remove X-Forwarded-For header"
      enabled     = true
      expression  = "(http.x_forwarded_for ne \"\")"
    }
  ]
}
