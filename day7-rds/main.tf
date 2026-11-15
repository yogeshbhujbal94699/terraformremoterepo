# creating RDS database 
resource "aws_db_instance" "default" {
  allocated_storage    = var.allocated_storage
  #identifier = "<name>"
  db_subnet_group_name = aws_db_subnet_group.default.id
  depends_on = [ aws_db_subnet_group.default ]
  db_name              = var.db_name
  engine               = var.engine
  engine_version       = var.engine_version
  instance_class       = var.instance_class  # the environment gets allocated according to class only 
  #multi_az = true 
  username             = var.username
  password             = var.password
  parameter_group_name = var.parameter_group_name
  skip_final_snapshot  = true
  publicly_accessible = true
  #backup_retention_period = 7
  # vpc_security_group-ids = [aws_security_group.<name>.id]
}

#create subnet group having two AZ and allocate to database so that database will create on mentioned subnets only
resource "aws_db_subnet_group" "default" {
  name       = var.name
  subnet_ids = var.subnet_ids
}
