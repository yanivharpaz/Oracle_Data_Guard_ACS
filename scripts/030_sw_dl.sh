echo "Downloading Oracle RDBMS Software into /tmp"
cd /tmp

curl -o oracle-database-preinstall-19c-1.0-2.el7.x86_64.rpm https://yum.oracle.com/repo/OracleLinux/OL7/latest/x86_64/getPackage/oracle-database-preinstall-19c-1.0-2.el7.x86_64.rpm

wget https://stgpubus.blob.core.windows.net/file-share/files/new/oracle-database-ee-19c-1.0-1.x86_64.rpm
wget https://stgpubus.blob.core.windows.net/file-share/files/LINUX.X64_193000_db_home.zip
