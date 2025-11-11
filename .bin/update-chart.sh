#!/usr/bin/env bash

set -o pipefail

# renovate: datasource=github-tags depName=operator-framework/operator-lifecycle-manager versioning=semver
OLM_VERSION="0.38.0"

mkdir -p tmp && cd tmp
cp ../chart/Chart.yaml Chart.yaml.bak
cp ../chart/ci.values.yaml ci.values.yaml.bak || true
git clone https://github.com/operator-framework/operator-lifecycle-manager.git
git -C operator-lifecycle-manager reset --hard "v$OLM_VERSION"
echo "Using OLM version=$OLM_VERSION"
rm  operator-lifecycle-manager/deploy/chart/Chart.yaml
rm -rf ../chart
mv operator-lifecycle-manager/deploy/chart ..
mv Chart.yaml.bak ../chart/Chart.yaml
mv ci.values.yaml.bak ../chart/ci.values.yaml || true
cd ..
sed -i.bak "s/version: .*/version: ${OLM_VERSION}/" chart/Chart.yaml
sed -i.bak "s/operator-framework\/olm:master$/operator-framework\/olm:v${OLM_VERSION}/" chart/values.yaml
rm chart/Chart.yaml.bak
rm chart/values.yaml.bak
rm -rf tmp
helm-docs chart/
git add .
