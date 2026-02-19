# ============================================================================
# Module Outputs — what the caller can read
# ============================================================================
# CloudFormation equivalent: Outputs in a nested stack
#   → accessible via !GetAtt NestedStack.Outputs.OutputKey
# Terraform equivalent:
#   → accessible via module.my_service.container_id
# ============================================================================

output "container_id" {
  description = "Docker container ID"
  value       = docker_container.service.id
}

output "container_name" {
  description = "Docker container name"
  value       = docker_container.service.name
}

output "network_name" {
  description = "Docker network name for this service"
  value       = docker_network.service_network.name
}

output "url" {
  description = "URL to access the service"
  value       = "http://localhost:${var.external_port}"
}
