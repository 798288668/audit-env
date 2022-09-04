#!/bin/sh

echo "check git"
which git > /dev/null
if [ $? -eq 0 ]
then
    echo "docker is exist"
    git --version
else
    yum -y install git
    git --version
    if [ ! -d "$HOME/.ssh" ]; then
      ssh-keygen -t ed25519 -C "798288668@qq.com"
    fi
fi
