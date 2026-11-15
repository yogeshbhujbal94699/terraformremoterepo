resource "aws_db_instance" "default" {
  allocated_storage    = 10
  db_name              = "mydb"
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t4g.micro"
  username             = "admin"
  password             = "Ef23DYQM"
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true
}
resource "aws_db_subnet_group" "default" {
  name       = "my-sg"
  subnet_ids = ["subnet-058c2a9df20a5e8b2", "subnet-017034798114d24b6"]
  tags = {
    Name = "my-sg"
  }
}
