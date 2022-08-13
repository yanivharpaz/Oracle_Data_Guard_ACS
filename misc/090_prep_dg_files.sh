#!/bin/bash

cp -pvf ~vscode/Oracle_Data_Guard_ACS/misc/oracle_rdbms_config_sample.conf /tmp

export ORACLE_HOME=/opt/oracle/product/19c/dbhome_1

# General exports and vars
export PATH=$ORACLE_HOME/bin:$PATH
LSNR=$ORACLE_HOME/bin/lsnrctl
SQLPLUS=$ORACLE_HOME/bin/sqlplus
DBCA=$ORACLE_HOME/bin/dbca
NETCA=$ORACLE_HOME/bin/netca
ORACLE_OWNER=oracle
RETVAL=0
#CONFIG_NAME="oracledb_$ORACLE_SID-$ORACLE_VERSION.conf"
#CONFIGURATION="/etc/sysconfig/$CONFIG_NAME"

NEW_CONFIG_NAME="oracle_rdbms_config_sample.conf"
NEW_CONFIGURATION="/tmp/$NEW_CONFIG_NAME"

. "$NEW_CONFIGURATION"

prep_standby_init_ora() {
    # create init.ora file for the standby database
    echo "creating init.ora file for the standby database -> $ORACLE_TEMP_INIT_ORA"
    cat > $ORACLE_TEMP_INIT_ORA <<EOF
*.db_name=$ORACLE_SID
EOF
}

create_tnsnames_ora() {
    # create tnsnames.ora file
    echo "creating tnsnames.ora file -> $ORACLE_TNSNAMES_ORA"
    cat > $ORACLE_TNSNAMES_ORA <<EOF
$ORACLE_PRIMARY_SID =
(DESCRIPTION =
    (ADDRESS = (PROTOCOL = TCP)(HOST = $PRIMARY_HOSTNAME)(PORT = $LISTENER_PORT))
    (CONNECT_DATA =
    (SERVER = DEDICATED)
    (SID    = $ORACLE_PRIMARY_SID)(UR=A)
    )
)
$ORACLE_STANDBY_TNS =
(DESCRIPTION =
    (ADDRESS = (PROTOCOL = TCP)(HOST = $STANDBY_HOSTNAME)(PORT = $LISTENER_PORT))
    (CONNECT_DATA =
    (SERVER = DEDICATED)
    (SID    = $ORACLE_PRIMARY_SID)(UR=A)
    )
)
EOF
}

create_primary_listener_ora() {
    # create listener.ora file for the primary database
    echo "creating listener.ora file for the primary database -> $ORACLE_LISTENER_ORA_PRIMARY"
    cat > $ORACLE_LISTENER_ORA_PRIMARY << EOF
LISTENER =
(DESCRIPTION_LIST =
    (DESCRIPTION =
    (ADDRESS = (PROTOCOL = TCP)(HOST = $PRIMARY_HOSTNAME)(PORT = $LISTENER_PORT))
    (ADDRESS = (PROTOCOL = IPC)(KEY = EXTPROC1521))
    )
)

SID_LIST_LISTENER =
(SID_LIST       =
    (SID_DESC     =
    (GLOBAL_DBNAME = $ORACLE_PRIMARY_DGMGRL)
    (ORACLE_HOME   = $ORACLE_HOME)
    (SID_NAME      = $ORACLE_PRIMARY_SID)
    )
)
ADR_BASE_LISTENER = $ORACLE_BASE
EOF
}

create_standby_listener_ora() {
    # create listener.ora file for the standby database
    echo "creating listener.ora file for the standby database -> $ORACLE_LISTENER_ORA_STBY"
    cat > $ORACLE_LISTENER_ORA_STBY << EOF
LISTENER =
(DESCRIPTION_LIST =
    (DESCRIPTION =
    (ADDRESS = (PROTOCOL = TCP)(HOST = $STANDBY_HOSTNAME)(PORT = $LISTENER_PORT))
    (ADDRESS = (PROTOCOL = IPC)(KEY = EXTPROC1521))
    )
)

SID_LIST_LISTENER =
(SID_LIST       =
    (SID_DESC     =
    (GLOBAL_DBNAME = $ORACLE_STANDBY_DGMGRL)
    (ORACLE_HOME   = $ORACLE_HOME)
    (SID_NAME      = $ORACLE_PRIMARY_SID)
    )
)
ADR_BASE_LISTENER = $ORACLE_BASE
EOF
}

create_rman_restore_command() {
    # create rman restore command file
    echo "creating rman restore command file -> $ORACLE_RMAN_CMD"
    cat > $ORACLE_RMAN_CMD << EOF
DUPLICATE TARGET DATABASE
  FOR STANDBY
  FROM ACTIVE DATABASE
  DORECOVER
  SPFILE
    SET db_unique_name='$ORACLE_STANDBY_TNS' COMMENT 'Is standby'
  NOFILENAMECHECK;
EOF
}

create_rman_restore_step() {
    # create rman_login.ora file
    echo "creating rman_login.ora file -> $ORACLE_RMAN_LOGIN"
    cat > $ORACLE_RMAN_LOGIN << EOF
rman TARGET sys/$SYS_PASSWORD@$ORACLE_PRIMARY_SID AUXILIARY sys/$SYS_PASSWORD@$ORACLE_STANDBY_TNS cmdfile=$ORACLE_RMAN_CMD
EOF
chmod +x $ORACLE_RMAN_LOGIN
}

dg_broker_start() {
    cat > $ORACLE_DG_BROKER_START << EOF
connect / as sysdba
ALTER SYSTEM SET dg_broker_start=true;
EXIT;
EOF
}

mkdir_commands() {
    # create commands directory
    echo "creating commands directory -> $ORACLE_COMMANDS_DIR"
    cat > $ORACLE_COMMANDS_DIR << EOF
mkdir -p $ORACLE_INSTANCE_LOCATION/archivelog
mkdir -p $ORACLE_INSTANCE_LOCATION/autobackup
mkdir -p $ORACLE_INSTANCE_LOCATION/flashback
mkdir -p $ORACLE_INSTANCE_LOCATION/ORCLPDB1
mkdir -p $ORACLE_INSTANCE_LOCATION/pdbseed

mkdir -p $ORACLE_ADMIN_DEST/adump
EOF

chmod +x $ORACLE_COMMANDS_DIR
}

orapwd_command() {
    # create orapwd command file
    echo "creating orapwd command file -> $ORACLE_ORAPWD_CMD"
    cat > $ORACLE_ORAPWD_CMD << EOF
orapwd file=$ORACLE_HOME/dbs/orapw$ORACLE_SID password=$SYS_PASSWORD entries=10
EOF
chmod +x $ORACLE_ORAPWD_CMD
}

startup_nomount() {
    # create startup_nomount command file
    echo "creating startup_nomount command file -> $ORACLE_STARTUP_NOMOUNT_CMD"
    cat > /tmp/startup_nomount.sql << EOF
startup nomount pfile=$ORACLE_TEMP_INIT_ORA
exit;
EOF

    cat > $ORACLE_STARTUP_NOMOUNT_CMD << EOF
sqlplus / as sysdba @/tmp/startup_nomount.sql
EOF
chmod +x $ORACLE_STARTUP_NOMOUNT_CMD
}

test_setup_change_sys_password() {
    # test the setup change sys password command
    echo "testing the setup change sys password command -> $ORACLE_TEST_CHANGE_SYS_PASSWORD"
    cat > $ORACLE_TEST_CHANGE_SYS_PASSWORD << EOF
connect / as sysdba
ALTER user sys identified by $SYS_PASSWORD;
EXIT;
EOF
chmod +x $ORACLE_TEST_CHANGE_SYS_PASSWORD
}

prep_standby_init_ora
create_primary_listener_ora
create_tnsnames_ora
create_primary_listener_ora
create_standby_listener_ora
create_rman_restore_command
create_rman_restore_step
mkdir_commands
orapwd_command
startup_nomount


