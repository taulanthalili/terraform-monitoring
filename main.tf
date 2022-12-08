resource "helm_release" "monitoring_application" {
  name       = "monitoring-${var.environment}"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
  version    = var.prometheus_versions.helm

  namespace = var.namespace
  set {
    name = "grafana"
    value = <<-EOT
              ingress:
                enabled: true
    EOT
  }
}
