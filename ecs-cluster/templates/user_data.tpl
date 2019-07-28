#!/bin/bash
sudo yum update -y

sudo yum install docker git -y

git clone https://github.com/swatkiev/finaldocker.git

cd /finaldocker/docker

sudo systemctl enable docker

service docker start

docker build -t finaljenkins .

docker run --rm -p 80:8080 -v /var/run/docker.sock:/var/run/docker.sock -v $(which docker):/usr/bin/docker finaljenkins
