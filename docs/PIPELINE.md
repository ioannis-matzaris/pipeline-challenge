# Pipeline

This document describes the **abstract architecture** of the CI/CD pipeline used in the *pipeline-challenge* repository.  
It focuses on the conceptual flow, system boundaries and how the pipeline components interact, i.e not on implementation details.

---

## 1. High‑Level Concept

The pipeline forms an automated path from **source code → built application → container image → deployment**.

At its core, it connects three systems:

1. **GitHub Actions** – performs all build, test and packaging automation.
2. **GitHub Container Registry (GHCR)** – stores versioned application container images.
3. **Argo CD** – continuously deploys the latest approved container image to the Kubernetes environment.

Together, these create a self‑updating, GitOps‑driven delivery loop.

---

## 2. Architectural Stages

### **Stage 1: Continuous Integration (CI)**  
Goal: Validate and assemble the application.

**Responsibilities:**
- Detect new commits to any branch.
- Run automated tests to verify code correctness.
- Build the Java application into a deployable artifact.

**Abstract behavior:**  
> *Ensure that the codebase is always in a buildable, test‑passing state.*

---

### **Stage 2: Artifact Packaging**

Goal: Convert the built application into a container image.

**Responsibilities:**
- Take the application artifacts from CI.
- Build a deterministic Docker image.
- Produce an immutable artifact suitable for deployment.

**Abstract behavior:**  
> *Transform application code into a standardized unit (a container image) that the platform can run.*

---

### **Stage 3: Artifact Publication**

Goal: Make the container image available to the deployment ecosystem.

**Responsibilities:**
- Publish the built image to GHCR.
- Tag the image according to the commit or versioning strategy.
- Guarantee that deployments always reference immutable, traceable images.

**Abstract behavior:**  
> *Expose a trusted, versioned release artifact to the runtime environment.*

---

### **Stage 4: GitOps Deployment (Argo CD)**

Goal: Keep the running environment synchronized with desired state.

Argo CD watches either:

- A Git repo containing Kubernetes manifests referencing the container image, or  
- An Image Updater configuration that reacts to new GHCR image tags.

**Abstract behavior:**  
> *Argo CD continuously ensures that the cluster deploys whatever image version the pipeline designates as the latest.*

When a new image is published:

1. Argo CD detects the new version.
2. It updates or syncs the deployment configuration.
3. Kubernetes rolls out the new version.

No manual action is required.

---

## 3. End‑to‑End Architecture Summary

```
┌────────────────────┐
│   Developer Push    │
└──────────┬─────────┘
           ▼
┌────────────────────┐
│        CI           │
│ Test + Build        │
└──────────┬─────────┘
           ▼
┌────────────────────┐
│   Docker Packaging  │
└──────────┬─────────┘
           ▼
┌────────────────────┐
│  GHCR Publication   │
└──────────┬─────────┘
           ▼
┌────────────────────┐
│      Argo CD        │
│ Auto‑Deploys Image  │
└────────────────────┘
```

---

## 4. Core Architectural Principles

- **Immutability** — Every image is uniquely tied to a commit.
- **Automation** — No step depends on human-triggered actions.
- **Separation of Concerns**  
  - CI builds & validates  
  - Registry stores  
  - GitOps deploys  
- **Traceability** — Every deployment can be traced back to source commit and pipeline run.
- **Reproducibility** — Builds and deployments follow a consistent, deterministic path regardless of environment.

---

## 5. Abstract Lifecycle Overview

1. **Code Changes** — Developer commits code.
2. **Verification** — Pipeline ensures quality through testing.
3. **Assembly** — Application is turned into a container image.
4. **Publication** — Image is pushed to GHCR.
5. **Reconciliation** — Argo CD detects changes and updates the cluster.
6. **Deployment** — Kubernetes rolls out the new version.

This completes a fully automated, self‑healing delivery system.

