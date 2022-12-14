echo "Install Oracle RDBMS Software"
sudo yum update -y
sudo yum localinstall -y /tmp/oracle-database-preinstall-19c-1.0-2.el7.x86_64.rpm
sudo yum localinstall -y /tmp/oracle-database-ee-19c-1.0-1.x86_64.rpm

sudo sed 's/ORACLE_SID=ORCLCDB/ORACLE_SID=CDB1/g' /etc/init.d/oracledb_ORCLCDB-19c > /tmp/setup_cdb1.sh
sudo chmod +x /tmp/setup_cdb1.sh

echo "Setup CDB1 - (sudo or under root) execute:   sudo ~/acs-il-data-guard-oracle-user/scripts/150_create_instance.sh CDB1 "
sudo cp -pv /tmp/setup_cdb1.sh $HOME/Oracle_Data_Guard_ACS/scripts
sudo cp -pv /etc/sysconfig/oracledb_ORCLCDB-19c.conf /etc/sysconfig/oracledb_CDB1-19c.conf


