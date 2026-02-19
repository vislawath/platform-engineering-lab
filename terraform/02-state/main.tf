# ============================================================================
# Terraform State Management
# ============================================================================
# This exercise will be completed in Project 2B when we set up GCS as the
# remote backend. For now, this is a reference for state concepts.
#
# LOCAL STATE (default — what we used in 01-basics and 03-modules):
#   terraform.tfstate file in the same directory
#   Problem: only one person can run terraform at a time
#   Problem: state contains secrets in plaintext
#   Problem: if you lose the file, Terraform loses track of all resources
#
# REMOTE STATE (production pattern — what Zions would use):
#   State stored in a shared backend (GCS bucket, S3 bucket, Terraform Cloud)
#   Benefits:
#     - Team collaboration (state locking prevents conflicts)
#     - Encryption at rest
#     - Versioning (can roll back state)
#     - Centralized management
#
# CloudFormation equivalent:
#   CF doesn't have this concept because AWS manages stack state internally.
#   Terraform requires YOU to manage state — more flexible but more responsibility.
#
# GCS Backend Configuration (for Project 2B):
#   terraform {
#     backend "gcs" {
#       bucket = "zions-platform-lab-tfstate"
#       prefix = "terraform/state"
#     }
#   }
#
# State Commands to Know:
#   terraform state list              — list all resources in state
#   terraform state show <resource>   — show details of one resource
#   terraform state mv                — rename a resource in state
#   terraform state rm                — remove a resource from state (doesn't destroy it)
#   terraform import <resource> <id>  — import existing infrastructure into state
# ============================================================================

# Placeholder — will be populated in Project 2B
terraform {
  required_version = ">= 1.0"
}
