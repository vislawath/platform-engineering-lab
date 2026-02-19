# ============================================================================
# Reusable Module: Docker Service
# ============================================================================
# CloudFormation equivalent: A Nested Stack
# Jenkins equivalent: A shared library function
# GitHub Actions equivalent: A reusable workflow
#
# This module encapsulates "a running Docker service" into a reusable unit.
# Any caller can create a service by providing inputs (image, name, port).
#
# Why modules matter for Zions:
#   Instead of every team writing their own Terraform for GKE namespaces,
#   RBAC, quotas, etc. — the platform team provides modules:
#     module "team_alpha" { source = "./modules/team-namespace" }
#   Same golden path pattern, but for infrastructure.
# ============================================================================

terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

# ── Docker Network (isolated per service) ──────────────────────────────────
resource "docker_network" "service_network" {
  name = "${var.service_name}-network"
}

# ── Docker Image ───────────────────────────────────────────────────────────
resource "docker_image" "service" {
  name         = var.image
  keep_locally = true
}

# ── Docker Container ───────────────────────────────────────────────────────
resource "docker_container" "service" {
  name  = var.service_name
  image = docker_image.service.image_id

  ports {
    internal = var.internal_port
    external = var.external_port
  }

  # Attach to service-specific network
  networks_advanced {
    name = docker_network.service_network.id
  }

  env = var.environment_variables

  # Restart policy — like a K8s Deployment's restart policy
  restart = "unless-stopped"
}
