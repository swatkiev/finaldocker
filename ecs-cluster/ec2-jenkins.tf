resource "aws_key_pair" "deployer" {
  key_name   = "docker"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDdNWn9XfejcOVkE6Pn0499RhNY52REQvYx0RqXGcZh8yRA8ZjojajRzs5empZUvt4BMi7abOFT44XmvQMNKVU25QAuOXVP1QXAmlKDT5AynBvxQ6EtdkvwRWridigi1rGIouDRYhkJLWbtMxB+UyS1n2IYwWhLCLkPmqJFgCaIMC08/wmwZ3PTx+o/VFtNN+nkRagsUty7b3SA8gt3BI6c1LRwb8tVOLALL7tnO6banYsZxBR46Wp8zM18+eB5IHjltBLUFhoEwc/gXF4Tk2D5K5YYAWV0rPukwZsV6BCbpewESSFE1g3QzpaP6AdBK9XcuKa0zMBDMx083I3JG5xH root@sviatoslav-N53SV"
}

data "template_file" "user_data" {
  template = "${file("templates/user_data.tpl")}"
}

resource "aws_security_group" "alloy-web" {
  name   = "jenkins-security-group"
  ingress {
    from_port         = 22
    to_port           = 22
    protocol          = "TCP"
    cidr_blocks       = ["0.0.0.0/0"]
  }
  ingress {
    from_port         = 80
    to_port           = 80
    protocol          = "TCP"
    cidr_blocks       = ["0.0.0.0/0"]
  }
  ingress {
    from_port         = 443
    to_port           = 443
    protocol          = "TCP"
    cidr_blocks       = ["0.0.0.0/0"]
  }
  egress {
    from_port         = 0
    to_port           = 0
    protocol          = "-1"
    cidr_blocks       = ["0.0.0.0/0"]
  }
}


resource "aws_instance" "jenkins" {
  ami           = "${var.ami_id_docker}"
  instance_type = "t2.micro"
  iam_instance_profile = "${aws_iam_instance_profile.ecs-instance-profile.id}"
  key_name = "${aws_key_pair.deployer.key_name}"
  security_groups = ["${aws_security_group.alloy-web.name}"]
  user_data = "${data.template_file.user_data.rendered}"
}
