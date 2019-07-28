#data "aws_ecs_task_definition" "nginx" {
#  task_definition = "${aws_ecs_task_definition.nginx.family}"
#}

resource "aws_ecs_task_definition" "nginx" {
    family                = "hello_world"
    container_definitions = <<DEFINITION
[ 
  {
    "name": "nginx",
    "image": "swatkiev/finaldocker:${var.dockertag}",
    "portMappings": [
      {
        "containerPort": 80,
        "hostPort": 80
      }
    ],
    "memory": 500
  }
]
DEFINITION
}
