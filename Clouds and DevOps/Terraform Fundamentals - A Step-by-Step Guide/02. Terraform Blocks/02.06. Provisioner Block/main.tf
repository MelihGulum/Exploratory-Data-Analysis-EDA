resource "aws_instance" "web_server" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
  key_name      = var.key_name

  # Local-exec provisioner
  provisioner "local-exec" {
    command     = "echo 'Instance creation completed!' > instance_status.txt"
    interpreter = ["bash", "-c"]
  }

  # Remote-exec provisioner
  provisioner "remote-exec" {
    inline = [
      "echo 'Hello from remote!' > /tmp/remote_message.txt",
      "sudo yum update -y"
    ]

    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file(var.private_key_path)
      host        = self.public_ip
    }
  }
}
