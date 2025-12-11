# Continuous Deployment Requirements

This document lists the high-level requirements to have continuous deployment for the **pipeline-challenge** repository.

---

## 1. Kubernetes Cluster
- A running Kubernetes cluster is required.
- `kubectl` must be configured to interact with the cluster.

## 2. Argo CD Installation
Argo CD must be deployed in the cluster to manage application deployments.

```bash
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```

## 3. Argo CD Image Updater
The Argo CD Image Updater is required to automatically detect new container images and trigger deployments.

```bash
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj-labs/argocd-image-updater/v0.12.0/manifests/install.yaml
```

## 4. Application Deployment Manifest
- The `application.yaml` manifest must be deployed to the kubernetes cluster.
- This manifest defines which repository and image tags Argo CD should track.

```bash
kubectl apply -f application.yaml
```

---

By meeting these requirements, the pipeline ensures automated continuous deployment.
