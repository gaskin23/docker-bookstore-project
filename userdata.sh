#! /bin/bash
sudo yum update -y
sudo amazon-linux-extras install docker -y
sudo yum install git -y
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -a -G docker ec2-user
sudo curl -L "https://github.com/docker/compose/releases/download/1.26.2/docker-compose-$(uname -s)-$(uname -m)" \
-o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo mkdir -p /home/ec2-user/bookstore
cd /home/ec2-user/bookstore
sudo git clone 
docker-compose up -d