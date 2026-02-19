# ============================================================================
# Variables — Parameterize your infrastructure
# ============================================================================
# CloudFormation equivalent: Parameters section
#
# Variables make your config reusable. Instead of hardcoding "nginx:alpine",
# you parameterize it so the same config works for any image.
#
# How to set variable values (in priority order, highest wins):
#   1. Command line:        terraform apply -var="image_name=httpd:latest"
#   2. .tfvars file:        terraform apply -var-file="prod.tfvars"
#   3. Environment var:     TF_VAR_image_name=httpd:latest terraform apply
#   4. terraform.tfvars:    auto-loaded if file exists
#   5. Default value:       what's defined below
#
# CloudFormation equivalent mapping:
#   variable "x" { default = "y" }  →  Parameters: x: Default: "y"
#   variable "x" { type = string }  →  Parameters: x: Type: String
#   var.x                           →  !Ref x
# ============================================================================

variable "image_name" {
  description = "Docker image to run"
  type        = string
  default     = "nginx:alpine"
}

variable "container_name" {
  description = "Name for the Docker container"
  type        = string
  default     = "platform-lab-web"
}

variable "host_port" {
  description = "Host port to map to container port 80"
  type        = number
  default     = 8080
}
