data "terraform_remote_state" "ecs" {
  backend = "local"

  config {
    path = "../ecs-cluster/terraform.tfstate"
  }
}

resource "aws_ecs_service" "test-ecs-service" {
  	name            = "test-ecs-service"
  	iam_role        = "${var.ecs_iam_role}"
  	cluster         = "${var.ecs_cluster}"
  	task_definition = "${aws_ecs_task_definition.nginx.arn}"
  	desired_count   = 1

  	load_balancer {
    	  target_group_arn  = "${data.terraform_remote_state.ecs.ecs-target-group-arn}"
    	  container_port    = 80
    	  container_name    = "nginx"
	}
}
