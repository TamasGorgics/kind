#!/bin/sh

echo "Waiting for Docker to start"
let i=0; while ! docker ps; do let i=i+1; [ $i -le 12 ] || exit 1 && sleep 5; done || exit 1

set -e

$CLUSTER_NAME || { export CLUSTER_NAME=kind; }

kind delete cluster --name=$CLUSTER_NAME
kind create cluster --name=$CLUSTER_NAME

kubectl cluster-info --context kind-kind
kubectl get nodes -o wide
kubectl get pods --all-namespaces -o wide
kubectl get services --all-namespaces -o wide

trap : TERM INT; sleep infinity & wait

kind delete cluster --name=$CLUSTER_NAME
