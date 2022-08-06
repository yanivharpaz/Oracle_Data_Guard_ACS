echo "Install Oracle RDBMS Software"
sudo yum update -y
sudo yum localinstall -y /tmp/oracle-database-preinstall-19c-1.0-2.el7.x86_64.rpm
sudo yum localinstall -y /tmp/oracle-database-ee-19c-1.0-1.x86_64.rpm
