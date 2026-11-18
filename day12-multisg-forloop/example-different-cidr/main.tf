resource "aws_security_group" "mysg" {
    name = "mysg"
    description = "allow all traffic"

    ingress = [
        {
            description = "allow ssh traffic"
            from_port = 22
            to_port = 22
            protocol = "tcp"
            cidr_blocks = ["0.0.0.0/0"]
        },
         {
            description = "allow http traffic"
            from_port = 80
            to_port = 80
            protocol = "tcp"
            cidr_blocks = ["0.0.0.0/0"]
        },
         {
            description = "allow https traffic"
            from_port = 443
            to_port = 443
            protocol = "tcp"
            cidr_blocks = ["0.0.0.0/0"]
        },
         {
            description = "app access from internal vpc"
            from_port = 8080
            to_port = 8080
            protocol = "tcp"
            cidr_blocks = ["0.0.0.0/0"]
        },
        {
            description = "sonarQube or Jenkins access"
            from_port = 9000
            to_port = 9000
            protocol = "tcp"
            cidr_blocks = ["0.0.0.0/0"]
        }
     ]
     egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
     }
}