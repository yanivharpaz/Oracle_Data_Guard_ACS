
cp ~/Oracle_Data_Guard_ACS/misc/oracle_rdbms_config_sample.conf /tmp

sudo chmod +x ./Oracle_Data_Guard_ACS/scripts/*.sh
./Oracle_Data_Guard_ACS/scripts/010_yum_prep.sh
./Oracle_Data_Guard_ACS/scripts/030_sw_dl.sh
./Oracle_Data_Guard_ACS/scripts/050_install_sw.sh






