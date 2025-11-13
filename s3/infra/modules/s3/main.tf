resource "aws_bucket_s3" "this" {
    id = var.bucket_id
    tags = {
        Enviroment = var.enviroment
    }
}