# Install RDBMS on Centos

## Prep install git and wget
```
sudo yum install -y git wget
```

## Clone the scripts
```
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


Thank you for reading.  
  

You can contact me at http://www.twitter.com/w1025
  