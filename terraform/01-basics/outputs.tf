# ============================================================================
# Outputs — Expose useful values after apply
# ============================================================================
# CloudFormation equivalent: Outputs section
#
# Outputs are displayed after `terraform apply` and can be queried with
# `terraform output`. They're also how modules expose values to callers
# (like CF nested stack outputs).
#
# CloudFormation equivalent mapping:
#   output "x" { value = resource.attr }  →  Outputs: x: Value: !GetAtt resource.attr
# ============================================================================

output "container_id" {
  description = "ID of the Docker container"
  value       = docker_container.web.id
}

output "container_name" {
  description = "Name of the Docker container"
  value       = docker_container.web.name
}

output "container_url" {
  description = "URL to access the running container"
  value       = "http://localhost:${var.host_port}"
}
