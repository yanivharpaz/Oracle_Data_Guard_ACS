
sudo cp -pv ~oracle/.bashrc /tmp/oracle_bashrc
sudo chmod 777 /tmp/oracle_bashrc

sudo cat >> /tmp/oracle_bashrc << EOF
#aliases
alias sss='sqlplus / as sysdba'
alias pmon='ps -ef | grep pmon | grep -v grep'
alias cdnet='cd $ORACLE_HOME/network/admin'

#variables
export ORACLE_HOME=/opt/oracle/product/19c/dbhome_1/
export ORACLE_SID=ORCLCDB
export PATH=\$PATH:\$ORACLE_HOME/bin
EOF

sudo cp -pv /tmp/oracle_bashrc ~oracle/.bashrc 
sudo chmod 644 ~oracle/.bashrc

