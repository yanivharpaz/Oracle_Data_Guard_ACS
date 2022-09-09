

sudo yum localinstall -y /tmp/oracle-database-preinstall-19c-1.0-2.el7.x86_64.rpm

sudo mkdir -p -m 755 /u01/app/oracle/product/19.0.0/dbhome_1
sudo chown -R oracle:oinstall /u01/app/oracle
sudo chown -R oracle:oinstall /tmp/LINUX.X64_193000_db_home.zip
sudo -u oracle mv /tmp/LINUX.X64_193000_db_home.zip /u01/app/oracle/product/19.0.0/dbhome_1
cd /u01/app/oracle/product/19.0.0/dbhome_1
sudo -u oracle unzip LINUX.X64_193000_db_home.zip


/u01/app/oracle/product/19.0.0/dbhome_1/runInstaller.sh -silent -ignoreSysPrereqs -responseFile /tmp/oradb.rsp

sudo /u01/app/oracle/product/19.0.0/dbhome_1/root.sh

/u01/app/oracle/product/19.0.0/dbhome_1/runInstaller  -executeConfigTools -responseFile /tmp/oradb.rsp -silent

