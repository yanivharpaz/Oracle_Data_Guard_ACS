sudo -u oracle /u01/app/oracle/product/19.0.0/dbhome_1/runInstaller -silent -responseFile /tmp/sw_only.rsp
sudo /u01/app/oracle/product/19.0.0/dbhome_1/root.sh
sudo -u oracle /u01/app/oracle/product/19.0.0/dbhome_1/runInstaller  -executeConfigTools -responseFile /tmp/sw_only.rsp -silent

