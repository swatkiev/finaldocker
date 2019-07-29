
resource "aws_lb" "ecs-load-balancer" {
    name                = "ecs-load-balancer"
    security_groups     = ["${aws_security_group.test_private_sg.id}"]
    subnets             = ["${aws_subnet.test_public_sn_01.id}", "${aws_subnet.test_public_sn_02.id}"]

    tags {
      Name = "ecs-load-balancer"
    }
}

resource "aws_lb_target_group" "ecs-target-group" {
    name                = "ecs-target-group"
    port                = "80"
    protocol            = "HTTP"
    vpc_id              = "${aws_vpc.test_vpc.id}"

    health_check {
        healthy_threshold   = "5"
        unhealthy_threshold = "2"
        interval            = "30"
        matcher             = "200"
        path                = "/"
        port                = "traffic-port"
        protocol            = "HTTP"
        timeout             = "5"
    }

    tags {
      Name = "ecs-target-group"
    }

  depends_on = ["aws_lb.ecs-load-balancer"]
}

resource "aws_lb_listener" "lb-listener" {
    load_balancer_arn = "${aws_lb.ecs-load-balancer.arn}"
    port              = "80"
    protocol          = "HTTP"

    default_action {
        target_group_arn = "${aws_lb_target_group.ecs-target-group.arn}"
        type             = "forward"
    }
}
