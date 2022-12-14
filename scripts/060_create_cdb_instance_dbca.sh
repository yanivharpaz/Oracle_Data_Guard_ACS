

time dbca -silent -createDatabase \
  -templateName General_Purpose.dbc \
  -gdbname CDB1 \
  -sid CDB1 \
  -responseFile NO_VALUE \
  -characterSet AL32UTF8 \
  -sysPassword OraPasswd1 \
  -systemPassword Ora_Passwd1 \
  -createAsContainerDatabase true \
  -numberOfPDBs 1 \
  -pdbName PDB1 \
  -pdbAdminPassword Ora_Passwd1 \
  -databaseType MULTIPURPOSE \
  -automaticMemoryManagement false \
  -storageType FS \
  -datafileDestination /u01/app/oracle/oradata \
  -ignorePreReqs

