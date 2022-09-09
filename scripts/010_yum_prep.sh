#!/bin/bash
echo "yum install RPMs for the Oracle RDMS Software"

export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LC_COLLATE=C
export LC_CTYPE=en_US.UTF-8

sudo yum update -y
sudo yum-complete-transaction
sudo yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm

sudo yum install -y epel-release apt-transport-https conntrack git mc ncdu zsh htop vim gcc jq ftp 
sudo yum install -y python36 python36-devel python36-pip python-devel python-virtualenv
sudo yum install -y bind-utils mlocated yum-utils createrepo bin-utils openssh-clients perl parted

sudo yum install -y binutils.x86_64 compat-libcap1.x86_64 gcc.x86_64 gcc-c++.x86_64
sudo yum install -y glibc.i686 glibc.x86_64 glibc-devel.i686 glibc-devel.x86_64 ksh compat-libstdc++-33
sudo yum install -y libaio.i686 libaio.x86_64 libaio-devel.i686 libaio-devel.x86_64
sudo yum install -y libgcc.i686 libgcc.x86_64 libstdc++.i686 libstdc++.x86_64 libstdc++-devel.i686
sudo yum install -y libstdc++-devel.x86_64 libXi.i686 libXi.x86_64
sudo yum install -y libXtst.i686 libXtst.x86_64 make.x86_64 sysstat.x86_64

sudo yum install -y btrfs-progs btrfs-progs-devel
sudo yum install -y yum-utils zip unzip htop

sudo yum -y groupinstall "Development Tools"
sudo yum install -y openssl-devel bzip2-devel libffi-devel xz-devel

sudo yum install -y python3-pip

if [[ $(grep -c pmon ~/.bashrc) > 0 ]]; then
    echo "already got pmon alias"
else
    echo "no pmon alias - adding one"
    cat >> ~/.bashrc << EOF
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LC_COLLATE=C
export LC_CTYPE=en_US.UTF-8
alias pmon='ps -ef | grep pmon | grep -v grep'
alias ll='ls -ltrh'
alias 2ora='sudo su - oracle'
EOF
fi


