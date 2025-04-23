provider "aws" {
  region = var.region
}

resource "aws_key_pair" "deployer" {
  key_name   = "dotnet-key"
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_security_group" "allow_web" {
  name        = "allow_web_traffic"

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

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "dotnet_app" {
  ami           = "ami-08d4ac5b634553e16" # Ubuntu 22.04 in us-west-2
  instance_type = "t2.micro"
  key_name      = aws_key_pair.deployer.key_name
  security_groups = [aws_security_group.allow_web.name]
  user_data     = file("init.sh")

  tags = {
    Name = "DotnetWebApp"
  }
}

resource "aws_db_instance" "postgres" {
  identifier         = "dotnet-db"
  engine             = "postgres"
  instance_class     = "db.t3.micro"
  username           = "postgres"
  password           = var.db_password
  allocated_storage  = 20
  skip_final_snapshot = true
  publicly_accessible = true
}
