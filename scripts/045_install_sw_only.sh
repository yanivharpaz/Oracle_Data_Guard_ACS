sudo -u oracle /opt/oraServer/ora19/runInstaller -silent -responseFile /tmp/sw_only.rsp
sudo /opt/oraServer/ora19/root.sh
sudo -u oracle /opt/oraServer/ora19/runInstaller  -executeConfigTools -responseFile /tmp/sw_only.rsp -silent

