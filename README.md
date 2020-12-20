# kind
Docker image for Kubernetes in Docker (KinD) with Helm

## Usage
```bash
docker pull tgorgics/kind:1.0.0_basic-cluster
docker run -it --rm --privileged --network=host -v /var/run/docker.sock:/var/run/docker.sock tgorgics/kind:1.0.0_basic-cluster
```
