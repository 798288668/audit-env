#!/bin/sh

echo "check wget"
which wget > /dev/null
if [ $? -eq 0 ]
then
    echo "wget is exist"
else
    echo "wget not exist"
    echo "install wget"
    sudo yum install -y wget
fi

echo "check docker"
which docker > /dev/null
if [ $? -eq 0 ]
then
    echo "docker is exist"
    docker version
else
    # install docker
    echo "install docker"
    sudo yum update -y
    wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo
    sudo yum -y install epel-release
    sudo yum -y install container-selinux
    sudo yum install -y yum-utils device-mapper-persistent-data lvm2
    sudo yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
    # sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
    sudo yum -y install docker-ce
    systemctl enable docker
    systemctl start docker
    docker version

    # network optimize
    echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf
    sysctl -p
    service network restart
    systemctl restart docker

    # docker network create
    echo "docker network create app_net"
    docker network create app_net

    # update docker mirror
    echo "update docker mirror"
    sudo mkdir -p /etc/docker
    sudo tee /etc/docker/daemon.json <<-'EOF'
{
 "registry-mirrors": ["https://7uh64jga.mirror.aliyuncs.com"]
}
EOF

    # restart
    sudo systemctl daemon-reload
    sudo systemctl restart docker
fi

echo "check docker-compose"
which docker-compose > /dev/null
if [ $? -eq 0 ]
then
    echo "docker-compose is exist"
    docker-compose version
else
    echo "docker-compose not exist"
    echo "install docker-compose"
    sudo curl -L https://get.daocloud.io/docker/compose/releases/download/2.6.1/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
    # sudo curl -L https://github.com/docker/compose/releases/download/1.24.1/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
    chmod +x /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
    docker-compose version
fi