cd ~
git clone https://github.com/yanivharpaz/Oracle_Data_Guard_ACS.git
cp ~/Oracle_Data_Guard_ACS/scripts/* /tmp

cd /tmp
sudo yum localinstall -y /tmp/oracle-database-preinstall-19c-1.0-2.el7.x86_64.rpm

sudo mkdir -p -m 755 /u01/app/oracle/product/19.0.0/dbhome_1
sudo chown -R oracle:oinstall /u01/app/oracle
sudo chown -R oracle:oinstall /tmp/LINUX.X64_193000_db_home.zip
sudo -u oracle mv /tmp/LINUX.X64_193000_db_home.zip /u01/app/oracle/product/19.0.0/dbhome_1
cd /u01/app/oracle/product/19.0.0/dbhome_1
sudo -u oracle unzip LINUX.X64_193000_db_home.zip

sudo chmod +x /tmp/*.sh
sudo /tmp/orainstRoot.sh
sudo /tmp/root.sh

# sudo -u oracle /u01/app/oracle/product/19.0.0/dbhome_1/runInstaller -silent -responseFile /tmp/oradb.rsp

# sudo /u01/app/oracle/product/19.0.0/dbhome_1/root.sh

# sudo -u oracle /u01/app/oracle/product/19.0.0/dbhome_1/runInstaller  -executeConfigTools -responseFile /tmp/oradb.rsp -silent

sudo echo "export ORACLE_HOME=/u01/app/oracle/product/19.0.0/dbhome_1" >> /home/oracle/.bashrc
sudo echo "export LD_LIBRARY_PATH=$ORACLE_HOME/lib:/lib:/usr/lib" >> /home/oracle/.bashrc
sudo echo "export ORACLE_SID=CDB1" >> /home/oracle/.bashrc
sudo echo "export ORACLE_BASE=/u01/app/oracle" >> /home/oracle/.bashrc
sudo echo "export ORACLE_UNQNAME=CDB1" >> /home/oracle/.bashrc
sudo echo "export PATH=\$PATH:\$ORACLE_HOME/bin" >> /home/oracle/.bashrc

sudo cat >> /home/oracle/.bashrc << EOF

alias sss='sqlplus / as sysdba'
alias pmon='ps -ef | grep pmon | grep -v grep'
alias cdnet='cd \$ORACLE_HOME/network/admin'
alias dbs='cd \$ORACLE_HOME/dbs'
alias bdump='cd \$ORACLE_BASE/diag/rdbms'
alias ll='ls -ltrh'
alias restart_listener='lsnrctl stop; lsnrctl start'
alias drclog='less +F $(find /opt/oracle/diag/ -name "drc*")'
alias alertfind='find /opt/oracle/diag/ -name "alert_*" -exec ls -lh {} \;'

EOF

