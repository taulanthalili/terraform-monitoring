
#!/bin/bash

#Ref https://github.com/prometheus-community/helm-charts/blob/main/charts/kube-prometheus-stack/hack/update_crds.sh

# if [[ $(uname -s) = "Darwin" ]]; then
#     VERSION="$(grep ^appVersion ../Chart.yaml | sed 's/appVersion: /v/g')"
# else
#     VERSION="$(grep ^appVersion ../Chart.yaml | sed 's/appVersion:\s/v/g')"
# fi
VERSION="v0.60.1"

FILES=(
  "crd-alertmanagerconfigs.yaml :  monitoring.coreos.com_alertmanagerconfigs.yaml"
  "crd-alertmanagers.yaml       :  monitoring.coreos.com_alertmanagers.yaml"
  "crd-podmonitors.yaml         :  monitoring.coreos.com_podmonitors.yaml"
  "crd-probes.yaml              :  monitoring.coreos.com_probes.yaml"
  "crd-prometheuses.yaml        :  monitoring.coreos.com_prometheuses.yaml"
  "crd-prometheusrules.yaml     :  monitoring.coreos.com_prometheusrules.yaml"
  "crd-servicemonitors.yaml     :  monitoring.coreos.com_servicemonitors.yaml"
  "crd-thanosrulers.yaml        :  monitoring.coreos.com_thanosrulers.yaml"
)

for line in "${FILES[@]}"; do
    DESTINATION=$(echo "${line%%:*}" | xargs)
    SOURCE=$(echo "${line##*:}" | xargs)

    URL="https://raw.githubusercontent.com/prometheus-operator/prometheus-operator/$VERSION/example/prometheus-operator-crd/$SOURCE"

    echo -e "Downloading Prometheus Operator CRD with Version ${VERSION}:\n${URL}\n"

    echo "# ${URL}" > ./crds/"${DESTINATION}"
    curl -L "${URL}" | sed -E -e '/^ +creationTimestamp:/d' -e '/^status:$/,$ d' >> ./crds/"${DESTINATION}"

    # if ! curl --silent --retry-all-errors --fail --location "${URL}" >> ./crds/"${DESTINATION}"; then
    #   echo -e "Failed to download ${URL}!"
    #   exit 1
    # fi
done