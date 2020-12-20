FROM docker:19.03-dind

# https://github.com/kubernetes/kubernetes/releases
ENV KUBE_VERSION="v1.19.4"
# https://github.com/kubernetes/helm/releases
ENV HELM_VERSION="v3.4.1"
# https://github.com/kubernetes-sigs/kind/releases
ENV KIND_VERSION="v0.9.0"

RUN apk update && apk add --no-cache ca-certificates bash git openssh curl \
    && wget -q https://storage.googleapis.com/kubernetes-release/release/${KUBE_VERSION}/bin/linux/amd64/kubectl -O /usr/local/bin/kubectl \
    && chmod +x /usr/local/bin/kubectl \
    && wget -q https://get.helm.sh/helm-${HELM_VERSION}-linux-amd64.tar.gz -O - | tar -xzO linux-amd64/helm > /usr/local/bin/helm \
    && chmod +x /usr/local/bin/helm \
    && wget -q https://kind.sigs.k8s.io/dl/${KIND_VERSION}/kind-linux-amd64 -O /usr/local/bin/kind \
    && chmod +x /usr/local/bin/kind
    
WORKDIR /kind
COPY kind-config.yaml .
COPY setup_cluster.sh .
RUN chmod +x setup_cluster.sh

ENTRYPOINT ["sh", "-c"]
CMD ["sh /kind/setup_cluster.sh"]
