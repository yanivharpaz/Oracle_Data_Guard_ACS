sudo -u oracle /opt/oraServer/ora19/runInstaller -silent -responseFile /tmp/oradb.rsp
sudo /opt/oraServer/ora19/root.sh
sudo -u oracle /opt/oraServer/ora19/runInstaller  -executeConfigTools -responseFile /tmp/oradb.rsp -silent
