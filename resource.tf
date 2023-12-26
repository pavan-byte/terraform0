resource "aws_security_group" "my_security_group"{
  name = "my-security-group"
  vpc_id = "vpc-08fc1e01570464217"

 ingress {
  from_port = 22
  to_port = 22
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
 }

 ingress {
  from_port = 8080
  to_port = 8080
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

 egress {
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = ["0.0.0.0/0"]
}

tags = {
  name = "my-security-group"
 }
}
resource "aws_instance" "my_instance" {
 ami = "ami-0d92749d46e71c34c"
 instance_type = "t2.micro"
 key_name = "project"
 subnet_id = "subnet-0c735450e30fc4c0c"
 vpc_security_group_ids = ["sg-0013466b98c1e639e"]
 
 tags = {
  name = "my-instance"
  }
 }
resource "null_resource" "install_ansible" {
 provisioner "remote-exec" {
  inline = [
     "sudo yum update -y",
     "sudo yum install epel-release -y",
     "sudo yum install python-pip -y",
     "sudo pip install ansible",
    ]

  connection {
    type = "ssh"
    user = "ec2-user"
    private_key = file("/root/terra/project.pem")
    host = "15.206.170.209"
  }
 }
}
resource "null_resource" "run_ansible" {
 provisioner "remote-exec" {
  inline = ["echo 'wait until SSH is ready'"]

 connection {
   type = "ssh"
   user = "ec2-user"
   private_key = file("/root/terra/project.pem")
   host = "${"15.206.170.209"}"
 }
}
 provisioner "local-exec" {
    command = "ansible-playbook -i ${"3.109.217.215"}, --private-key ${("/root/terra/project.pem")} ansible.yml"
  }
 }

