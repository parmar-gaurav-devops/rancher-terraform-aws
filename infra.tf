
resource "aws_security_group" "rancher_sg_allowall" {
  name        = "rancher-allowall"
  description = "Rancher - allow all traffic"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Creator = "rancher"
  }
}

resource "aws_instance" "rancher_server" {
  ami             = data.aws_ami.ubuntu.id
  instance_type   = var.instance_type
  key_name        = aws_key_pair.ssh.id
  security_groups = [aws_security_group.rancher_sg_allowall.id]
  subnet_id       = tolist(data.aws_subnet_ids.publicsub.ids)[0]
  user_data       = data.template_file.cloud_config.rendered
  associate_public_ip_address = true

  provisioner "remote-exec" {
    inline = [
      "sleep 300",
      "echo 'Waiting for cloud-init to complete...'",
      "cloud-init status --wait > /dev/null",
      "echo 'Completed cloud-init!'",
    ]

    connection {
      type        = "ssh"
      host        = self.public_ip
      user        = local.node_username
      private_key = tls_private_key.ssh.private_key_pem
    }
  }

  tags = {
    Name    = "rancher-server"
  }
  depends_on = [var.subnet_depends_on]
}
