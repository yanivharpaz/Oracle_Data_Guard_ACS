#!/bin/bash
echo "yum install RPMs for the Oracle RDMS Software"
sudo yum update -y

sudo yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm

sudo yum install -y epel-release apt-transport-https conntrack git mc ncdu zsh htop vim gcc jq
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
sudo yum -y install openssl-devel bzip2-devel libffi-devel xz-devel


cat >> ~/.bashrc << EOF

alias pmon='ps -ef | grep pmon | grep -v grep'
alias ll='ls -ltrh'

EOF


# # create a function that checks if the oracle database is running and if it is it returns 0 otherwise it returns 1
# function check_ora_db_running() {
#     if [ -z "$(ps -ef | grep ora_pmon | grep -v grep)" ]; then
#         echo "got a pmon running"
#         return 1
#     else
#         echo "no pmon running"
#         return 0
#     fi
# }

