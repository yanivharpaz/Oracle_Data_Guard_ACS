echo "Configuring ORACLE_HOME and ORACLE_SID"
sudo cp -pv ~oracle/.bashrc /tmp/oracle_bashrc
sudo chmod 777 /tmp/oracle_bashrc

sudo cat >> /tmp/oracle_bashrc << EOF
#variables

export ORACLE_HOME=/u01/app/oracle/product/19.0.0/dbhome_1
export ORACLE_BASE=/u01/app/oracle
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
alias restart_listener='lsnrctl stop; lsnrctl start'
alias drclog='less +F $(find /opt/oracle/diag/ -name "drc*")'
alias alertfind='find /opt/oracle/diag/ -name "alert_*" -exec ls -lh {} \;'

EOF

sudo cp -pv /tmp/oracle_bashrc ~oracle/.bashrc 
sudo chmod 644 ~oracle/.bashrc

