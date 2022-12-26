output "cluster_endpoint" {
  description = "endpoint for eks control plane"
  value       = module.eks.cluster_endpoint
}

output "cluster_security_group_id" {
  description = "security group ids attached to the cluster control plane"
  value       = module.eks.cluster_security_group_id
}

output "region" {
  description = "aws region"
  value       = var.region
}

output "cluster_name" {
  description = "kubernetes cluster name"
  value       = module.eks.cluster_name
}

