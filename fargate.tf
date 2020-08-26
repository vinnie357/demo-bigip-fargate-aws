resource aws_ecs_cluster example-ecs-cluster {
  name = "example-ecs-cluster"
}

resource aws_ecs_task_definition app {
  family                   = "app"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.fargate_cpu
  memory                   = var.fargate_memory
  container_definitions    = <<DEFINITION
[

  {

    "cpu": ${var.fargate_cpu},

    "image": "${var.app_image}",

    "memory": ${var.fargate_memory},

    "name": "app",

    "networkMode": "awsvpc",

    "portMappings": [

      {

        "containerPort": ${var.app_port},

        "hostPort": ${var.app_port}

      }

    ]

  }

]

DEFINITION

}

resource aws_ecs_service main {
  name            = "example-ecs-service"
  cluster         = aws_ecs_cluster.example-ecs-cluster.id
  task_definition = aws_ecs_task_definition.app.arn
  desired_count   = var.app_count
  launch_type     = "FARGATE"
  network_configuration {
    subnets = [module.vpc.public_subnets[0]]

  }
  service_registries {
    registry_arn = aws_service_discovery_service.example.arn
  }

}