#!/usr/bin/env bash

set -o pipefail

# renovate: datasource=github-tags depName=operator-framework/operator-lifecycle-manager versioning=semver
OLM_VERSION="v0.25.0"

mkdir -p tmp && cd tmp
git clone https://github.com/operator-framework/operator-lifecycle-manager.git
git -C operator-lifecycle-manager reset --hard "$OLM_VERSION"
echo "Using OLM version=$OLM_VERSION"
sed -i.bak "s/^[Vv]ersion:.*\$/version: ${OLM_VERSION}/" operator-lifecycle-manager/deploy/chart/Chart.yaml
rm operator-lifecycle-manager/deploy/chart/Chart.yaml.bak
rm -rf ../chart
mv operator-lifecycle-manager/deploy/chart ..
cd ..
rm -rf tmp
