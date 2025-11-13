output ecs_exec_role {
    value       = aws_iam_role.ecs_exec_role.arn
    description = "ARN of the ECS Exec Role"
}