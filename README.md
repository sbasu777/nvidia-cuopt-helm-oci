# nvidia-cuopt-helm-oci
Helm Chart for the cuOpt OKE based deployment

# OCI Stack to Deploy cuOpt on OKE Using Helm Chart

## Prerequisites

An existing OKE cluster with a node pool using the A10 shape and 80GB of boot disk is required. Follow these instructions to create a new node pool with a larger boot size than the default: [OKE Node Sizing for Very Large Container Images](https://blogs.oracle.com/ateam/post/oke-node-sizing-for-very-large-container-images).

## How to Use This Stack

This stack allows you to deploy the cuOpt Helm chart on a selected OKE cluster. You can choose between deploying the cuOpt API with a public IP (LoadBalancer) or keeping it internal to the cluster (ClusterIP).
The cuOpt service will be deployed in a new namespace called "cuopt"

### Steps

1. **Enter Required Information:**

    - **OKE Cluster Selection:** Select the OKE cluster where you want to deploy the cuOpt Helm chart.
    - **Service Type:** Choose between `LoadBalancer` (public IP) and `ClusterIP` (internal).
    - **NVIDIA NGC API Key:** Enter a valid NVIDIA NGC API key.

2. **Deploy the Stack:**

    Click the button below to deploy the stack to OCI:

    [![Deploy to OCI](https://docs.oracle.com/en-us/iaas/Content/Resources/Images/deploy-to-oracle-cloud.svg)](https://cloud.oracle.com/resourcemanager/stacks/create?zipUrl=https://github.com/guido-orcl/nvidia-cuopt-helm-oci/archive/refs/heads/main.zip)

## Configuration Variables

- **OKE Cluster:** The OKE cluster where the Helm chart will be deployed.
- **Service Type:** The type of the Kubernetes service (`ClusterIP` or `LoadBalancer`).
- **NVIDIA NGC API Key:** The API key for accessing NVIDIA NGC.

