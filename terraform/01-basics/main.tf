# ============================================================================
# Terraform Basics — Docker Provider
# ============================================================================
# CloudFormation equivalent: An AWS::ECS::TaskDefinition + Service
# but using Docker directly (no cloud, instant feedback, zero cost).
#
# This exercise teaches core Terraform concepts:
#   - Providers (like CF "AWS::..." resource types)
#   - Resources (like CF resource blocks)
#   - Variables (like CF Parameters)
#   - Outputs (like CF Outputs)
#   - terraform init / plan / apply / destroy lifecycle
#
# Commands:
#   terraform init     — download the Docker provider
#   terraform plan     — preview what will be created
#   terraform apply    — create the resources
#   terraform destroy  — tear everything down
# ============================================================================

# ── Terraform Settings ─────────────────────────────────────────────────────
# CloudFormation equivalent: AWSTemplateFormatVersion + Transform
# Specifies which providers we need and their versions
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"   # Provider from Terraform Registry
      version = "~> 3.0"               # Version constraint (like package.json)
    }
  }
  required_version = ">= 1.0"
}

# ── Provider Configuration ─────────────────────────────────────────────────
# CloudFormation equivalent: no direct equivalent (CF is AWS-only)
# Terraform supports multiple providers (Docker, AWS, GCP, Azure, K8s, etc.)
# This connects to your local Docker daemon
provider "docker" {}

# ── Resources ──────────────────────────────────────────────────────────────
# CloudFormation equivalent: Resources section

# Pull an image — like `docker pull nginx:alpine`
# CloudFormation equivalent: no direct equivalent
resource "docker_image" "web" {
  name         = var.image_name       # Parameterized via variable
  keep_locally = true                 # Don't delete image on terraform destroy
}

# Create a container — like `docker run -d -p 8080:80 --name my-web nginx:alpine`
# CloudFormation equivalent: AWS::ECS::TaskDefinition + AWS::ECS::Service
resource "docker_container" "web" {
  name  = var.container_name
  image = docker_image.web.image_id   # Reference another resource's attribute
                                       # CF equivalent: !Ref or !GetAtt

  # Port mapping — like `docker run -p 8080:80`
  ports {
    internal = 80                      # Container port
    external = var.host_port           # Host port (parameterized)
  }

  # Environment variables — like `docker run -e KEY=VALUE`
  env = [
    "NGINX_HOST=${var.container_name}.local",
    "NGINX_PORT=80"
  ]
}
