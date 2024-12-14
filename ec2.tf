provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "wordpress_sg" {
  name        = "wordpress-SG1"
  description = "Allow HTTP, HTTPS, SSH, and MySQL traffic"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create an EC2 instance for WordPress
resource "aws_instance" "wordpress1" {
  ami           = "ami-0166fe664262f664c"
  instance_type = "t2.micro"
  key_name      = "docker"              
  subnet_id     = "subnet-0ad2d5a05cd9b3c15"            
  security_groups = [aws_security_group.wordpress_sg.id]

  user_data = file("data.sh")            

  tags = {
    Name = "WordPressServer1"
  }
}
