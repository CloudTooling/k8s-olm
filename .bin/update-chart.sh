#!/usr/bin/env bash

set -o pipefail

# renovate: datasource=github-tags depName=operator-framework/operator-lifecycle-manager versioning=semver
OLM_VERSION="0.28.0"

mkdir -p tmp && cd tmp
cp ../chart/Chart.yaml Chart.yaml.bak
git clone https://github.com/operator-framework/operator-lifecycle-manager.git
git -C operator-lifecycle-manager reset --hard "v$OLM_VERSION"
echo "Using OLM version=$OLM_VERSION"
rm  operator-lifecycle-manager/deploy/chart/Chart.yaml
rm -rf ../chart
mv operator-lifecycle-manager/deploy/chart ..
mv Chart.yaml.bak ../chart/Chart.yaml
cd ..
sed -i.bak "s/operator-framework\/olm:master$/operator-framework\/olm:v${OLM_VERSION}/" chart/values.yaml
rm chart/values.yaml.bak
rm -rf tmp
helm-docs chart/