#!/usr/bin/env bash

set -o pipefail

# renovate: datasource=github-tags depName=operator-framework/operator-lifecycle-manager versioning=semver
OLM_VERSION="0.26.0"

mkdir -p tmp && cd tmp
git clone https://github.com/operator-framework/operator-lifecycle-manager.git
git -C operator-lifecycle-manager reset --hard "v$OLM_VERSION"
echo "Using OLM version=$OLM_VERSION"
sed -i.bak "s/^[Vv]ersion:.*\$/version: ${OLM_VERSION}/" operator-lifecycle-manager/deploy/chart/Chart.yaml
rm operator-lifecycle-manager/deploy/chart/Chart.yaml.bak
rm -rf ../chart
mv operator-lifecycle-manager/deploy/chart ..
cd ..
sed -i.bak "s/operator-framework\/olm:master$/operator-framework\/olm:v${OLM_VERSION}/" chart/values.yaml
rm chart/values.yaml.bak
rm -rf tmp
helm-docs chart/