resource "argocd_application" "monitoring" {
  metadata {
    name      = "monitoring-${var.environment}"
    namespace = var.namespace
    labels = {
      environment = var.environment
      namespace   = var.namespace
    }
  }
  wait = true
  timeouts {
    create = "20m"
    delete = "10m"
  }
  spec {
    project = var.argocd_project
    source {
      repo_url        = "https://prometheus-community.github.io/helm-charts"
      chart           = "kube-prometheus-stack"
      target_revision = var.prometheus_versions.helm
      helm {
        skip_crds    = true
        value_files  = ["values.yaml"]
        release_name = var.environment


        parameter {
          name  = "grafana.ingress.enabled"
          value = true
        }
        parameter {
          name  = "grafana.ingress.ingressClassName"
          value = var.ingressClassName
        }
        parameter {
          name  = "grafana.ingress.hosts[0]"
          value = "grafana.${var.base_domain}"
        }
        #Loki data source
        parameter {
          name  = "grafana.additionalDataSources[0].name"
          value = "loki"
        }
        parameter {
          name  = "grafana.additionalDataSources[0].type"
          value = "loki"
        }
        parameter {
          name  = "grafana.additionalDataSources[0].url"
          value = "http://${var.namespace}-loki:3100"
        }
        parameter {
          name  = "grafana.additionalDataSources[0].access"
          value = "proxy"
        }
        parameter {
          name  = "grafana.additionalDataSources[0].orgId"
          value = "1"
        }
        parameter {
          name  = "grafana.additionalDataSources[0].version"
          value = "1"
        }

      }

    }
    destination {
      server    = "https://kubernetes.default.svc"
      namespace = var.namespace
    }
    sync_policy {
      automated = {
        prune       = true
        self_heal   = true
        allow_empty = true
      }
      sync_options = ["Validate=false", "RespectIgnoreDifferences=true"]
      retry {
        limit = "5"
        backoff = {
          duration     = "30s"
          max_duration = "2m"
          factor       = "2"
        }
      }
    }
    # ignore_difference {
    #   #respectExistingValue = true
    #   kind          = "Service"
    #   name          = "${var.environment}-elasticsearch-master-hl"
    #   json_pointers = ["/spec/clusterIP"]
    # }
  }
  lifecycle {
    ignore_changes = [metadata]
  }
}
