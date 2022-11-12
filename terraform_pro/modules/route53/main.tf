data "aws_route53_zone" "hosted_zone" {
  zone_id = "Z03163992YT5NDUHMPZ6I"
  #name = "mydevopsjourney.link.com."
  private_zone = false
}

# creating A record for domain:
resource "aws_route53_record" "websiteurl" {
  name    = var.domain_name
  zone_id = data.aws_route53_zone.hosted_zone.zone_id
  type    = "A"

  alias {
    name                   = var.cf_dist_domain_name
    zone_id                = var.cf_dist_hosted_zone_id
    evaluate_target_health = true
  }
}