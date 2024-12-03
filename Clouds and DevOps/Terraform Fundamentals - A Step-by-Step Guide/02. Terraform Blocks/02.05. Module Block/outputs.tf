output "root_instance_id" {
  description = "The ID of the EC2 instance"
  value       = module.ec2_instance.module_instance_id
}
