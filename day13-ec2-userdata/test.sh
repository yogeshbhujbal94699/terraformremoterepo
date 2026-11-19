#! /bin/bash       #<---shebang line
sudo yum update -y
sudo yum install -y httpd
sudo service httpd start
sudo systemctl enable httpd
echo wlcome yogesh > /var/www/html/index.html