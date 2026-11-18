variable "allowed_ports" {
    type = map(string)
    default = {
        22 = "10.0.0.0/24"  #ssh (restrict to office IP)
        80 = "0.0.0.0/0"    # HTTP (public)
        443 = "0.0.0.0/0"    # HTTPS (public)
        8080 = "10.0.0.0/16"  #internal app (restrict to vpc)
        9000 = "10.0.0.0/24"   #SonarQube/Jenkins (restrict to VPN)
    } 
}

resource "aws_security_group" "mysg" {
    name = "mysg"
    description = "allow inbound traffic"

    dynamic "ingress" {
        for_each = var.allowed_ports
        content {
            description = "allow access to port ${ingress.key}"
            from_port = ingress.key
            to_port = ingress.key
            protocol = "tcp"
            cidr_blocks = [ingress.value]
        }
      
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}