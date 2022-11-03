# Install Oracle RDBMS on Centos / Oracle Linux  

Use this guide / scripts only for testing and learning purpose 


## Prep install git and wget
```
# install git
sudo yum install -y git wget

# Clone the scripts repo
git clone https://github.com/yanivharpaz/Oracle_Data_Guard_ACS.git  

```

## Execute the yum prep script
```
chmod +x ./Oracle_Data_Guard_ACS/scripts/*.sh
./Oracle_Data_Guard_ACS/scripts/010_yum_prep.sh
```

## Download the Oracle RDBMS Software
```
cd /tmp

curl -o oracle-database-preinstall-19c-1.0-2.el7.x86_64.rpm https://yum.oracle.com/repo/OracleLinux/OL7/latest/x86_64/getPackage/oracle-database-preinstall-19c-1.0-2.el7.x86_64.rpm

wget https://stgpubus.blob.core.windows.net/file-share/files/new/oracle-database-ee-19c-1.0-1.x86_64.rpm

```

## Install the RDBMS Software
```
sudo yum update -y
sudo yum localinstall -y oracle-database-preinstall-19c-1.0-2.el7.x86_64.rpm
sudo yum localinstall -y oracle-database-ee-19c-1.0-1.x86_64.rpm

```
  
To configure a sample Oracle Database you can execute the following service configuration script as root: /etc/init.d/oracledb_ORCLCDB-19c configure   

## Install a sample database
```
sudo /etc/init.d/oracledb_ORCLCDB-19c configure
```

## Run prep -> software installation (zip file and response file) 
```
# install git
sudo yum install -y git wget

# Clone the scripts repo
git clone https://github.com/yanivharpaz/Oracle_Data_Guard_ACS.git  
git clone https://github.com/yanivharpaz/acs-il-data-guard-oracle-user.git   
#git clone https://github.com/yanivharpaz/ACS-IL-Oracle-RDBMS-Data-Guard.git  

cd ~
#cp ~/Oracle_Data_Guard_ACS/misc/oracle_rdbms_config_sample.conf /tmp
#cp -pvf ~/Oracle_Data_Guard_ACS/misc/110_restart_listener.sh /tmp
#cp -pvf ~/Oracle_Data_Guard_ACS/misc/210_change_sys_password.sh /tmp
#cp -pvf ~/Oracle_Data_Guard_ACS/misc/change_sys_password.sql /tmp

sudo chmod +x ./Oracle_Data_Guard_ACS/scripts/*.sh
./Oracle_Data_Guard_ACS/scripts/010_yum_prep.sh
./Oracle_Data_Guard_ACS/scripts/030_sw_dl.sh
./Oracle_Data_Guard_ACS/scripts/035_install_from_zip.sh

# for software and database creation
# ./Oracle_Data_Guard_ACS/scripts/040_install_full.sh

# for software only installation
# ./Oracle_Data_Guard_ACS/scripts/045_install_sw_only.sh


sudo mkdir -p /mnt/resource/oracle
sudo chown oracle:oinstall /mnt/resource/oracle/

# sudo mv /tmp/*.rpm /mnt/resource/oracle/
# sudo mv /tmp/LINUX.X64_* /mnt/resource/oracle/

# ./Oracle_Data_Guard_ACS/scripts/050_install_sw.sh
# ./Oracle_Data_Guard_ACS/scripts/070_setup_oraenv.sh

sudo pip3 install pyftpdlib wheel cython

ssh-keygen -q -t rsa -N '' -f ~/.ssh/id_rsa <<<y >/dev/null 2>&1

source ~/.bashrc
cat ~/.ssh/id_rsa.pub

```


## Run prep -> software installation (RPM) 
```
# install git
sudo yum install -y git wget

# Clone the scripts repo
git clone https://github.com/yanivharpaz/Oracle_Data_Guard_ACS.git  
git clone https://github.com/yanivharpaz/acs-il-data-guard-oracle-user.git  
#git clone https://github.com/yanivharpaz/ACS-IL-Oracle-RDBMS-Data-Guard.git  

cd ~
#cp ~/Oracle_Data_Guard_ACS/misc/oracle_rdbms_config_sample.conf /tmp
#cp -pvf ~/Oracle_Data_Guard_ACS/misc/110_restart_listener.sh /tmp
#cp -pvf ~/Oracle_Data_Guard_ACS/misc/210_change_sys_password.sh /tmp
#cp -pvf ~/Oracle_Data_Guard_ACS/misc/change_sys_password.sql /tmp

sudo chmod +x ./Oracle_Data_Guard_ACS/scripts/*.sh
./Oracle_Data_Guard_ACS/scripts/010_yum_prep.sh
./Oracle_Data_Guard_ACS/scripts/030_sw_dl.sh

sudo mkdir -p /mnt/resource/oracle
sudo chown oracle:oinstall /mnt/resource/oracle/

# sudo mv /tmp/*.rpm /mnt/resource/oracle/
# sudo mv /tmp/LINUX.X64_* /mnt/resource/oracle/

./Oracle_Data_Guard_ACS/scripts/050_install_sw.sh
./Oracle_Data_Guard_ACS/scripts/070_setup_oraenv.sh

sudo pip3 install pyftpdlib wheel cython

ssh-keygen -q -t rsa -N '' -f ~/.ssh/id_rsa <<<y >/dev/null 2>&1

source ~/.bashrc
cat ~/.ssh/id_rsa.pub

```


## Connect with password-less SSH
### Generate ssh keys  
 (Make sure you have open access with port 22)
```
ssh-keygen -q -t rsa -N '' -f ~/.ssh/id_rsa <<<y >/dev/null 2>&1
cat ~/.ssh/id_rsa.pub

```

## Test connectivity on port (with a python one liner)
### this example tries to connect to 10.0.1.5 on port 22
```
export REMOTE_NODE=10.0.1.5
export PORT_TO_CHECK=22

python -c 'import socket; import sys; s = socket.socket(socket.AF_INET); s.settimeout(5.0); s.connect((sys.argv[1], int(sys.argv[2]))); s.close();' $REMOTE_NODE $PORT_TO_CHECK

```

### Test output meaning:
* it will complete without any message immediately. 
* If it's closed, you will get this exception  
```
Traceback (most recent call last):
  File "<string>", line 1, in <module>
  File "/usr/lib64/python2.7/socket.py", line 224, in meth
    return getattr(self._sock,name)(*args)
socket.timeout: timed out
```

## increase volume size
```
sudo fdisk /dev/sda < ~/Oracle_Data_Guard_ACS/misc/fdisk_input.txt

# after reboot
sudo xfs_growfs /

```

## install Azure CLI (Centos)

```
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc

sudo sh -c 'echo -e "[azure-cli]
name=Azure CLI
baseurl=https://packages.microsoft.com/yumrepos/azure-cli
enabled=1
gpgcheck=1
gpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/azure-cli.repo'

sudo yum install -y azure-cli

```

## Install azcopy

```

wget https://aka.ms/downloadazcopy-v10-linux
mv downloadazcopy-v10-linux azcopy.tar.gz
tar xvf azcopy.tar.gz
sudo cp ./azcopy_linux_amd*/azcopy /usr/sbin
sudo chmod a+x /usr/sbin/azcopy

```


Thank you for reading.  
  

You can contact me at http://www.twitter.com/w1025
  
