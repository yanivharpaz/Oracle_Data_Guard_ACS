echo "Install Oracle RDBMS Software"
sudo yum update -y
sudo yum localinstall -y /tmp/oracle-database-preinstall-19c-1.0-2.el7.x86_64.rpm
sudo yum localinstall -y /tmp/oracle-database-ee-19c-1.0-1.x86_64.rpm

sudo sed 's/ORACLE_SID=ORCLCDB/ORACLE_SID=CDB1/g' /etc/init.d/oracledb_ORCLCDB-19c > /tmp/setup_cdb1.sh
sudo chmod +x /tmp/setup_cdb1.sh

echo "Setup CDB1 - under root execute: /tmp/setup_cdb1.sh configure "
sudo cp -pv /tmp/setup_cdb1.sh ~/Oracle_Data_Guard_ACS/scripts
