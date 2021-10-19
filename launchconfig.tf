resource "aws_launch_configuration" "asg-launch-config-sample" {
  image_id          = "ami-0b9064170e32bde34"
  instance_type = "t2.micro"
  security_groups = ["${aws_security_group.ssh-allowed.id}"]
  key_name = "terra-key-ohio"
  root_block_device {
    delete_on_termination = false
    volume_size           = 15
    volume_type           = "gp2"
  }
  
  user_data = <<-EOF
              #!/bin/bash
              /usr/bin/apt-get update
              /usr/bin/apt-get install apache2 -y
              /bin/echo "Hello World" >/var/www/html/index.html 
              EOF
  lifecycle {
    create_before_destroy = true
  }
}