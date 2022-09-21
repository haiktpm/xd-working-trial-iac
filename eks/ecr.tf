resource "aws_ecr_repository" "xd-ecr" {
  name                 = "xd-ecr"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = false
  }
  tags = {
    creator                       = "xd-trial"
    cost                          = "xd-trial"
  }
}