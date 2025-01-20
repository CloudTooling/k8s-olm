# k8s-olm

Kubernetes Chart for [Operator Lifecycle Manager](https://olm.operatorframework.io/)

[![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/olm)](https://artifacthub.io/packages/helm/olm/olm)

Credits to [kubitus for the idea](https://gitlab.com/kubitus-project/external-helm-charts/operator-lifecycle-manager).

## Deployment

### Helm

To install the Helm Chart use the [OCI Package Registry](https://github.com/orgs/CloudTooling/packages):

```
export HELM_EXPERIMENTAL_OCI=1
helm install olm oci://ghcr.io/cloudtooling/helm-charts/olm -n operator-lifecycle-manager --create-namespace
```
First run will fail, due to this [issue](https://github.com/kubernetes-sigs/cluster-api-addon-provider-helm/issues/221):
```
Error: INSTALLATION FAILED: 1 error occurred:
  * namespaces "operator-lifecycle-manager" already exists
```
But running it again will work:
```
$ helm upgrade --install olm oci://ghcr.io/cloudtooling/helm-charts/olm --version=0.28.1-dev -n operator-lifecycle-manager --create-namespace
Pulled: ghcr.io/cloudtooling/helm-charts/olm:0.28.1-dev
Digest: sha256:61a163ab5fabc36f1d742b75474a641570fcfe2d581f34f08587b0c7a33b23d5
Release "olm" has been upgraded. Happy Helming!
NAME: olm
LAST DEPLOYED: Sat Oct  5 07:30:18 2024
NAMESPACE: operator-lifecycle-manager
STATUS: deployed
REVISION: 2
TEST SUITE: None
```

If you're using terraform you have have to do the second run manual and then import it into your state:
```
terraform import helm_release.<name> operator-lifecycle-manager/olm
```

You can also adjust the namespaces:
```
helm -n olm upgrade --install olm oci://ghcr.io/cloudtooling/helm-charts/olm --create-namespace  --set catalog_namespace=olm
```
