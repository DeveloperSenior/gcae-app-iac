/** 
 * @author Andres Felipe Escobar López
 * @date 2024
 * @copyright Tecnologico de Antioquia 2024
 */

resource "aws_ecs_cluster" "gcae_app_cluster" {
  name = var.gcae_app_cluster_name
  tags = var.additional_tags
}

resource "aws_default_vpc" "default_vpc" {}

resource "aws_default_subnet" "default_subnet_a" {
  availability_zone = var.availability_zones[0]
  tags = var.additional_tags
}

resource "aws_default_subnet" "default_subnet_b" {
  availability_zone = var.availability_zones[1]
  tags = var.additional_tags
}

resource "aws_default_subnet" "default_subnet_c" {
  availability_zone = var.availability_zones[2]
  tags = var.additional_tags
}

resource "aws_ecs_task_definition" "gcae_app_task" {
  family                   = var.gcae_app_task_famliy
  container_definitions    = <<DEFINITION
  [
    {
      "name": "${var.gcae_app_task_name}",
      "image": "${var.ecr_repo_url}",
      "essential": true,
      "logConfiguration":{
          "logDriver" : "awslogs",
          "options" : {
            "awslogs-group" : "${var.gcae_app_awslogs_group}",
            "awslogs-region" : "${var.gcae_app_awslogs_region}",
            "awslogs-stream-prefix" : "${var.gcae_app_awslogs_stream_prefix}"          
          }
      },
      "portMappings": [
        {
          "containerPort": ${var.container_port},
          "hostPort": ${var.container_port}
        }
      ],
      "memory": ${var.gcae_app_task_memory},
      "cpu": ${var.gcae_app_task_cpu}
    }
  ]
  DEFINITION
  requires_compatibilities = [var.gcae_app_service_launch_type]
  network_mode             = var.gcae_app_service_network_mode
  memory                   = var.gcae_app_task_memory
  cpu                      = var.gcae_app_task_cpu
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  tags = var.additional_tags
}

resource "aws_iam_role" "ecs_task_execution_role" {
  name               = var.ecs_task_execution_role_name
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
  tags = var.additional_tags
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_policy" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_alb" "application_load_balancer" {
  name               = var.application_load_balancer_name
  load_balancer_type = "application"
  subnets = [
    "${aws_default_subnet.default_subnet_a.id}",
    "${aws_default_subnet.default_subnet_b.id}",
    "${aws_default_subnet.default_subnet_c.id}"
  ]
  security_groups = ["${aws_security_group.load_balancer_security_group.id}"]
  tags = var.additional_tags
}

resource "aws_security_group" "load_balancer_security_group" {
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = var.additional_tags
}

resource "aws_lb_target_group" "target_group" {
  name        = var.target_group_name
  port        = var.container_port
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = aws_default_vpc.default_vpc.id
  tags = var.additional_tags
}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_alb.application_load_balancer.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group.arn
  }
  tags = var.additional_tags
}

resource "aws_ecs_service" "gcae_app_service" {
  name            = var.gcae_app_service_name
  cluster         = aws_ecs_cluster.gcae_app_cluster.id
  task_definition = aws_ecs_task_definition.gcae_app_task.arn
  launch_type     = var.gcae_app_service_launch_type
  desired_count   = 1

  load_balancer {
    target_group_arn = aws_lb_target_group.target_group.arn
    container_name   = aws_ecs_task_definition.gcae_app_task.family
    container_port   = var.container_port
  }

  network_configuration {
    subnets          = ["${aws_default_subnet.default_subnet_a.id}", "${aws_default_subnet.default_subnet_b.id}", "${aws_default_subnet.default_subnet_c.id}"]
    assign_public_ip = true
    security_groups  = ["${aws_security_group.service_security_group.id}"]
  }
  tags = var.additional_tags
}

resource "aws_security_group" "service_security_group" {
  ingress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    security_groups = ["${aws_security_group.load_balancer_security_group.id}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = var.additional_tags
}