# ============================================================================
# Module Caller — Spin up multiple services using the reusable module
# ============================================================================
# This is the platform team's equivalent of:
#   module "team_alpha" { source = "./modules/team-namespace" }
#   module "team_beta"  { source = "./modules/team-namespace" }
#
# One module definition, multiple instances — same golden path pattern.
#
# CloudFormation equivalent:
#   TeamAlphaStack:
#     Type: AWS::CloudFormation::Stack
#     Properties:
#       TemplateURL: ./nested/service.yaml
#       Parameters:
#         ServiceName: frontend
# ============================================================================

terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {}

# ── Service 1: Frontend (Nginx) ────────────────────────────────────────────
# Like Team Alpha calling the golden path template
module "frontend" {
  source = "./modules/docker-service"

  service_name  = "frontend"
  image         = "nginx:alpine"
  external_port = 8080
  environment_variables = [
    "SERVICE_NAME=frontend",
    "BACKEND_URL=http://backend:8081"
  ]
}

# ── Service 2: Backend (httpd as stand-in) ─────────────────────────────────
# Like Team Beta calling the same golden path template
module "backend" {
  source = "./modules/docker-service"

  service_name  = "backend"
  image         = "httpd:alpine"
  external_port = 8081
  environment_variables = [
    "SERVICE_NAME=backend",
    "DB_HOST=database.internal"
  ]
}

# ── Outputs ────────────────────────────────────────────────────────────────
# Expose module outputs to the terminal
output "frontend_url" {
  value = module.frontend.url
}

output "backend_url" {
  value = module.backend.url
}

output "services" {
  value = {
    frontend = {
      name = module.frontend.container_name
      url  = module.frontend.url
    }
    backend = {
      name = module.backend.container_name
      url  = module.backend.url
    }
  }
}
