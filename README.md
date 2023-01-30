# terraform-monitoring
terraform-monitoring

How to use it

```
module "monitoring" {
  source = "git::https://github.com/taulanthalili/terraform-monitoring.git?ref=main"
  argocd_project  = "default"
  base_domain = module.data.defaults.main_domain
  namespace = module.data.defaults.project_name
  environment = module.data.defaults.environment
  ingressClassName = "nginx"
  prometheus_versions = {
    helm = module.data.helm_version.prometheus
  }
  labels = {
    environment = "prod"
    region      = "us-east-1"
  }
}
```
