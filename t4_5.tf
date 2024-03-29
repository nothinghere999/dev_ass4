data "aws_ami" "latest_ubuntu" {
  most_recent = true
  owners      = ["002000431150"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-20221018"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_key_pair" "ec2_key_pair" {
  key_name   = "cs423-ass4-key"
  public_key = file("cs423-assignment4-key.pub")
}

resource "aws_instance" "ec2_instance_web" {
  ami                    = data.aws_ami.latest_ubuntu.id
  instance_type         = "t2.micro"
  key_name              = aws_key_pair.ec2_key_pair.key_name
  subnet_id             = "subnet-0aec6393337d419af"
  associate_public_ip_address = true

  user_data = <<-EOF
              #!/bin/bash
              sudo apt update
              sudo apt install -y apache2
              sudo systemctl start apache2
              sudo systemctl enable apache2
              EOF

  tags = {
    Name = "Assignment4-EC2-Web"
  }
}

resource "aws_instance" "ec2_instance_db_ml" {
  ami                    = data.aws_ami.latest_ubuntu.id
  instance_type         = "t2.micro"
  key_name              = aws_key_pair.ec2_key_pair.key_name
  subnet_id             = "subnet-0aec6393337d419af"

  user_data = <<-EOF
              #!/bin/bash
              EOF

  tags = {
    Name = "Assignment4-EC2-DB-ML"
  }
}

output "private_key" {
  value       = aws_key_pair.ec2_key_pair.key_name
  description = "Private key for the created key pair"
}



#task5 part
output "web_instance_ips" {
  value = {
    public_ip  = aws_instance.ec2_instance_web.public_ip
    private_ip = aws_instance.ec2_instance_web.private_ip
  }
}

output "db_ml_instance_ips" {
  value = {
    public_ip  = aws_instance.ec2_instance_db_ml.public_ip
    private_ip = aws_instance.ec2_instance_db_ml.private_ip
  }
}
output "iam_user_details" {
  value = {
    user_name = "terraform-cs423-devops"

  }
}
