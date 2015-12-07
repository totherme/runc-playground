#!/bin/bash

# Use us.archive.ubuntu.com instead of EC2 mirrors, which are broken
sed -i -e 's/http.*\.archive\.ubuntu\.com/http:\/\/us.archive.ubuntu.com/' /etc/apt/sources.list

rm -rf /etc/apt/sources.list.d/multiverse-trusty*

apt-get -y update
apt-get -y clean

apt-get install -y git vim-nox jq cgroup-lite

wget -qO- https://storage.googleapis.com/golang/go1.4.2.linux-amd64.tar.gz | tar -C /usr/local -xzf -

#Set up $GOPATH and add go executables to $PATH
cat > /etc/profile.d/go_env.sh <<\EOF
export GOPATH=/root/go
export PATH=$GOPATH/bin:/usr/local/go/bin:$PATH
EOF
chmod +x /etc/profile.d/go_env.sh

source /etc/profile.d/go_env.sh

mkdir -p $GOPATH/src/github.com/opencontainers/
pushd $GOPATH/src/github.com/opencontainers/
git clone https://github.com/opencontainers/runc
pushd runc

GOPATH=$PWD/Godeps/_workspace:$GOPATH go build -o runc .
cp runc /usr/local/bin/runc

cp /vagrant/mount-tmpfs.sh /etc/init.d/
/etc/init.d/mount-tmpfs.sh start

cat /vagrant/vimrc >> /etc/vim/vimrc

export UCF_FORCE_CONFFNEW=YES
export DEBIAN_FRONTEND=noninteractive

