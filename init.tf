locals {
  # 기존 rule : {csp}-{service}-{tier}-{resource}-{env}-{region}-{extra_code}
  resource_prefix = join("-", [
    var.csp,
    var.service_name
    ])
  resource_suffix = join("-", [
    var.env,
    var.region_code])
  tags = merge(var.tags, {
    Owner = var.owner
    Service = var.service_name
    Env = var.env
  })
  az_count = length(var.azs)
}