#!/bin/sh
unset WAS_ROOTMACRO_CALL_MADE
. /u01/app/oracle/product/19.0.0/dbhome_1/install/utl/rootmacro.sh "$@"
. /u01/app/oracle/product/19.0.0/dbhome_1/install/utl/rootinstall.sh
/u01/app/oracle/product/19.0.0/dbhome_1/suptools/tfa/release/tfa_home/install/roottfa.sh
/u01/app/oracle/product/19.0.0/dbhome_1/install/root_schagent.sh

#
# Root Actions related to network
#
/u01/app/oracle/product/19.0.0/dbhome_1/network/install/sqlnet/setowner.sh 

#
# Invoke standalone rootadd_rdbms.sh
#
/u01/app/oracle/product/19.0.0/dbhome_1/rdbms/install/rootadd_rdbms.sh

/u01/app/oracle/product/19.0.0/dbhome_1/rdbms/install/rootadd_filemap.sh 
