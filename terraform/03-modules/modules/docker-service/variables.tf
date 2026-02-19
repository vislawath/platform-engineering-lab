# ============================================================================
# Module Inputs — what the caller provides
# ============================================================================
# CloudFormation equivalent: Parameters in a nested stack template
#
# When a team calls this module:
#   module "my_service" {
#     source        = "./modules/docker-service"
#     service_name  = "orders-api"        ← these are the inputs
#     image         = "my-orders:1.0"
#     external_port = 8081
#   }
# ============================================================================

variable "service_name" {
  description = "Name for the service (used for container and network names)"
  type        = string
}

variable "image" {
  description = "Docker image to run (e.g., nginx:alpine, httpd:latest)"
  type        = string
}

variable "internal_port" {
  description = "Container port the service listens on"
  type        = number
  default     = 80
}

variable "external_port" {
  description = "Host port to expose the service on"
  type        = number
}

variable "environment_variables" {
  description = "List of environment variables in KEY=VALUE format"
  type        = list(string)
  default     = []
}
