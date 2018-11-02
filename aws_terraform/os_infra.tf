data "aws_ami" "centos" {
  owners      = ["aws-marketplace"]
  most_recent = true

  filter {
    name   = "name"
    values = ["CentOS Linux 7*"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

#  filter {
#    name = "virtualization-type"
#    values = ["hvm"]
#  }

#  filter {
#    name   = "root-device-type"
#    values = ["ebs"]
#  }
}

resource "aws_instance" "master" {
  ami = "ami-3548444c"
  instance_type = "t2.micro"
  availability_zone = "eu-west-1a"
  tags {
    Name = "openshift-master"
  }
  root_block_device {
    volume_type = "gp2"
    volume_size = 32
    delete_on_termination = false
  }
}

resource "aws_instance" "node-1" {
  ami = "${data.aws_ami.centos.id}"
  instance_type = "t2.small"
  availability_zone = "eu-west-1b"
  tags {
    Name = "openshift-node-1"
  }
  root_block_device {
    volume_type = "gp2"
    volume_size = 10
    delete_on_termination = false
  }
  ebs_block_device {
    device_name = "/dev/sdb"
    volume_type = "gp2"
    volume_size = 10
  }
}

resource "aws_instance" "node-2" {
  ami = "${data.aws_ami.centos.id}"
  instance_type = "t2.small"
  availability_zone = "eu-west-1c"
  tags {
    Name = "openshift-node-2"
  }
  root_block_device {
    volume_type = "gp2"
    volume_size = 10
    delete_on_termination = false
  }
  ebs_block_device {
    device_name = "/dev/sdb"
    volume_type = "gp2"
    volume_size = 10
  }
}

