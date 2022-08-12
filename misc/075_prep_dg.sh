#!/bin/bash
#
# chkconfig: 2345 80 05
# Description: This script is responsible for taking care of configuring the Oracle Database and its associated services.
#
# processname: oracledb_ORCLCDB-19c
# Red Hat or SuSE config: /etc/sysconfig/oracledb_ORCLCDB-19c
#

# Set path if path not set
case $PATH in
	"") PATH=/bin:/usr/bin:/sbin:/etc
		 export PATH ;;
esac

# Setting the required environment variables
export ORACLE_HOME=/opt/oracle/product/19c/dbhome_1 

export ORACLE_VERSION=19c 
export ORACLE_SID=ORCLCDB
export TEMPLATE_NAME=General_Purpose.dbc
export CHARSET=AL32UTF8
export PDB_NAME=ORCLPDB1
export LISTENER_NAME=LISTENER
export NUMBER_OF_PDBS=1
export CREATE_AS_CDB=true

# General exports and vars
export PATH=$ORACLE_HOME/bin:$PATH
LSNR=$ORACLE_HOME/bin/lsnrctl
SQLPLUS=$ORACLE_HOME/bin/sqlplus
DBCA=$ORACLE_HOME/bin/dbca
NETCA=$ORACLE_HOME/bin/netca
ORACLE_OWNER=oracle
RETVAL=0
CONFIG_NAME="oracledb_$ORACLE_SID-$ORACLE_VERSION.conf"
CONFIGURATION="/etc/sysconfig/$CONFIG_NAME"

# Commands
if [ -z "$SU" ];then SU=/bin/su; fi
if [ -z "$GREP" ]; then GREP=/usr/bin/grep; fi
if [ ! -f "$GREP" ]; then GREP=/bin/grep; fi


# Entry point to configure the DB
configure()
{
    check_for_configuration
    RETVAL=$?
    if [ $RETVAL -eq 0 ]
    then
        echo "Oracle Database instance $ORACLE_SID is already configured."
        exit 1
    fi
    read_config_file
    check_port_availability
    check_em_express_port_availability
    configure_perform
}

check_port_availability()
{
    port=`netstat -n --tcp --listen | $GREP :$LISTENER_PORT`
    if [ "$port" != "" ]
    then
        echo "Port $LISTENER_PORT appears to be in use by another application. Specify a different port in the configuration file '$CONFIGURATION'"
        exit 1;
    fi
}

check_for_configuration()
{
    configfile=`$GREP --no-messages $ORACLE_SID:$ORACLE_HOME /etc/oratab` > /dev/null 2>&1
    if [ "$configfile" = "" ]
    then
        return 1
    fi
    return 0
}

read_config_file()
{
    if [ -f "$CONFIGURATION" ]
    then
        . "$CONFIGURATION"
    else
        echo "The Oracle Database is not configured. Unable to read the configuration file '$CONFIGURATION'"
        exit 1;
    fi
}


# To start the DB
prep_dg_01()
{
    check_for_configuration
    RETVAL=$?
    if [ $RETVAL -eq 1 ]
    then
        echo "The Oracle Database is not configured. You must run '/etc/init.d/oracledb_$ORACLE_SID-$ORACLE_VERSION configure' as the root user to configure the database."
        exit
    fi
    # Check if the DB is already started
    pmon=`ps -ef | egrep pmon_$ORACLE_SID'\>' | $GREP -v grep`
    if [ "$pmon" != "" ];
    then

        # Unset the proxy env vars before calling sqlplus
        unset_proxy_vars

        echo "Putting Oracle instance in archivelog $ORACLE_SID."
        $SU -s /bin/bash  $ORACLE_OWNER -c "$SQLPLUS -s /nolog << EOF
                                                                connect / as sysdba
                                                                spool /tmp/x.x
                                                                set echo on
                                                                SELECT log_mode FROM v\$database;
                                                                spool off
                                                                exit;
                                                                EOF" > /dev/null 2>&1
        RETVAL1=$?
        if [ $RETVAL1 -eq 0 ]
        then
            echo "Oracle Database instance $ORACLE_SID started."
        fi
    else
        echo "Oracle instance not running $ORACLE_SID."
        exit 0
    fi

    echo
    if [ $RETVAL -eq 0 ] && [ $RETVAL1 -eq 0 ]
    then
        return 0
     else
        echo "Failed to start Oracle Net Listener using $ORACLE_HOME/bin/tnslsnr and Oracle Database using $ORACLE_HOME/bin/sqlplus."
        exit 1
    fi
}


prep_dg_01

exit 0
