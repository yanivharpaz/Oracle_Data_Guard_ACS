# Install RDBMS on Centos

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

## Run everything
```
cp ~/Oracle_Data_Guard_ACS/misc/oracle_rdbms_config_sample.conf /tmp

sudo chmod +x ./Oracle_Data_Guard_ACS/scripts/*.sh
./Oracle_Data_Guard_ACS/scripts/010_yum_prep.sh
./Oracle_Data_Guard_ACS/scripts/030_sw_dl.sh
./Oracle_Data_Guard_ACS/scripts/050_install_sw.sh
./Oracle_Data_Guard_ACS/scripts/070_setup_oraenv.sh

```



Thank you for reading.  
  

You can contact me at http://www.twitter.com/w1025
  