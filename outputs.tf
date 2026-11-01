output "instance_id" {
  value = aws_instance.web.id
}

output "public_ip" {
  value = aws_instance.web.public_ip
}

output "ssh_command" {
  value = "ssh -i ~/.ssh/id_ed25519 ubuntu@{aws_instance.web.public_ip}"
}
