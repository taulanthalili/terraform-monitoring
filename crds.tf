resource "kubernetes_manifest" "alertmanagerconfigs_crd" {
  manifest = yamldecode(file("${path.module}/manifests/crds/crd-alertmanagerconfigs.yaml"))
}

resource "kubernetes_manifest" "alertmanagers_crd" {
  manifest = yamldecode(file("${path.module}/manifests/crds/crd-alertmanagers.yaml"))
}

resource "kubernetes_manifest" "podmonitors_crd" {
  manifest = yamldecode(file("${path.module}/manifests/crds/crd-podmonitors.yaml"))
}

resource "kubernetes_manifest" "probes_crd" {
  manifest = yamldecode(file("${path.module}/manifests/crds/crd-probes.yaml"))
}

resource "kubernetes_manifest" "prometheuses_crd" {
  manifest = yamldecode(file("${path.module}/manifests/crds/crd-prometheuses.yaml"))
}

resource "kubernetes_manifest" "prometheusrules_crd" {
  manifest = yamldecode(file("${path.module}/manifests/crds/crd-prometheusrules.yaml"))
}

resource "kubernetes_manifest" "servicemonitors_crd" {
  manifest = yamldecode(file("${path.module}/manifests/crds/crd-servicemonitors.yaml"))
}

resource "kubernetes_manifest" "thanosrulers_crd" {
  manifest = yamldecode(file("${path.module}/manifests/crds/crd-thanosrulers.yaml"))
}