# Copyright (c) 2020, 2022 Oracle and/or its affiliates. All rights reserved.
# Licensed under the Universal Permissive License v 1.0 as shown at http://oss.oracle.com/licenses/upl.
# 

# Commented for testing purposes
resource "kubernetes_namespace" "cuopt_namespace" {
  metadata {
    name = "cuopt"
  }
  # depends_on = [oci_containerengine_node_pool.oke_node_pool]
}
#Create secret
resource "kubernetes_secret" "ngc_docker_reg_secret" {
  metadata {
    name      = "ngc-docker-reg-secret"
    namespace = kubernetes_namespace.cuopt_namespace.id
  }

  data = {
    ".dockerconfigjson" = jsonencode({
      auths = {
        "nvcr.io" = {
          username = "$oauthtoken"
          password = var.nvidia_api_key
        }
      }
    })
  }

  type = "kubernetes.io/dockerconfigjson"
}

#Deploy helm
resource "helm_release" "cuopt" {
  name       = "cuopt"
  chart = "https://helm.ngc.nvidia.com/nvidia/charts/cuopt-24.03.00.tgz"
  namespace  = kubernetes_namespace.cuopt_namespace.id
  wait       = false
  repository_username = "$oauthtoken"
  repository_password = var.nvidia_api_key

  set {
    name = "applicationSpecs.cuopt-deployment.services.cuopt-service.type"
    value = var.service_type
  }

  set {
    name  = "tolerations[0].key"
    value = "nvidia.com/gpu"
  }

  set {
    name  = "tolerations[0].operator"
    value = "Exists"
  }

  set {
    name  = "tolerations[0].effect"
    value = "NoSchedule"
  }

  # values = [
  #   file("${path.module}/chart-values/cuopt.yaml"),
  # ]


  # depends_on = [kubernetes_deployment.cluster_autoscaler_deployment]
}

