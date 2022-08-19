echo "Configuring ORACLE_HOME and ORACLE_SID"
sudo cp -pv ~oracle/.bashrc /tmp/oracle_bashrc
sudo chmod 777 /tmp/oracle_bashrc

sudo cat >> /tmp/oracle_bashrc << EOF
#variables

export ORACLE_HOME=/opt/oracle/product/19c/dbhome_1
export ORACLE_BASE=/opt/oracle
#export ORACLE_SID=ORCLCDB
export ORACLE_SID=CDB1

export PATH=$PATH:\$ORACLE_HOME/bin

#aliases
alias sss='sqlplus / as sysdba'
alias pmon='ps -ef | grep pmon | grep -v grep'
alias cdnet='cd \$ORACLE_HOME/network/admin'
alias dbs='cd \$ORACLE_HOME/dbs'
alias bdump='cd \$ORACLE_BASE/diag/rdbms'
alias ll='ls -ltrh'

EOF

sudo cp -pv /tmp/oracle_bashrc ~oracle/.bashrc 
sudo chmod 644 ~oracle/.bashrc

