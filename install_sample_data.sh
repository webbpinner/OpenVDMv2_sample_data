#!/bin/bash -e

# OpenVDM is available as open source under the GPLv3 License at
#   https:/github.com/webbpinner/OpenVDMv2
#
# This script installs and configures OpenVDM to run on Ubuntu 20.04.  It
# is designed to be run as root. It should take a (relatively) clean
# Ubuntu 20.04 installation and install and configure all the components
# to run the full OpenVDM system.
#
# It should be re-run whenever the code has been refresh. Preferably
# by first running 'git pull' to get the latest copy of the script,
# and then running 'utils/build_openvdm_ubuntu20.04.sh' to run that
# script.
#
# The script has been designed to be idempotent, that is, if can be
# run over again with no ill effects.
#
# This script is somewhat rudimentary and has not been extensively
# tested. If it fails on some part of the installation, there is no
# guarantee that fixing the specific issue and simply re-running will
# produce the desired result.  Bug reports, and even better, bug
# fixes, will be greatly appreciated.


PREFERENCES_FILE='.install_openvdm_sample_data_preferences'

###########################################################################
###########################################################################
function exit_gracefully {
    echo Exiting.

    # Try deactivating virtual environment, if it's active
    if [ -n "$INSTALL_ROOT" ];then
        deactivate
    fi
    return -1 2> /dev/null || exit -1  # exit correctly if sourced/bashed
}

#########################################################################
#########################################################################
# Return a normalized yes/no for a value
yes_no() {
    QUESTION=$1
    DEFAULT_ANSWER=$2

    while true; do
        read -p "$QUESTION ($DEFAULT_ANSWER) " yn
        case $yn in
            [Yy]* )
                YES_NO_RESULT=yes
                break;;
            [Nn]* )
                YES_NO_RESULT=no
                break;;
            "" )
                YES_NO_RESULT=$DEFAULT_ANSWER
                break;;
            * ) echo "Please answer yes or no.";;
        esac
    done
}

###########################################################################
###########################################################################
# Read any pre-saved default variables from file
function set_default_variables {
    # Defaults that will be overwritten by the preferences file, if it
    # exists.
    DEFAULT_INSTALL_ROOT=/opt

    DEFAULT_SAMPLE_DATA_ROOT=/vault/sample_data

    DEFAULT_OPENVDM_REPO=https://github.com/webbpinner/OpenVDMv2_sample_data
    DEFAULT_OPENVDM_BRANCH=master

    DEFAULT_OPENVDM_USER=survey

    # Read in the preferences file, if it exists, to overwrite the defaults.
    if [ -e $PREFERENCES_FILE ]; then
        echo Reading pre-saved defaults from "$PREFERENCES_FILE"
        source $PREFERENCES_FILE
        echo branch $DEFAULT_OPENVDM_BRANCH
    fi
}


###########################################################################
###########################################################################
# Save defaults in a preferences file for the next time we run.
function save_default_variables {
    cat > $PREFERENCES_FILE <<EOF
# Defaults written by/to be read by install_openvdm_ubuntu20.04.sh

DEFAULT_HOSTNAME=$HOSTNAME
DEFAULT_INSTALL_ROOT=$INSTALL_ROOT

DEFAULT_SAMPLE_DATA_ROOT=$SAMPLE_DATA_ROOT

DEFAULT_OPENVDM_REPO=$OPENVDM_REPO
DEFAULT_OPENVDM_BRANCH=$OPENVDM_BRANCH

DEFAULT_OPENVDM_USER=$OPENVDM_USER

EOF
}


###########################################################################
###########################################################################
# Create user
function verify_user {

    OPENVDM_USER=$1

    echo "Verifying user $OPENVDM_USER exists"
    if ! id -u $OPENVDM_USER > /dev/null; then
        echo User does not exists, exiting
        exit_gracefully
    fi

}

###########################################################################
###########################################################################
# Install and configure required packages
function install_packages {

    apt-get update

}

###########################################################################
###########################################################################
# Install and configure database
function configure_samba {

    mv /etc/samba/smb.conf /etc/samba/smb.conf.orig

    sed -e '/### Added by OpenVDM_sample_data install script ###/,/### Added by OpenVDM_sample_data install script ###/d' /etc/samba/smb.conf.orig |
    sed -e :a -e '/^\n*$/{$d;N;};/\n$/ba'  > /etc/samba/smb.conf
    
    cat >> /etc/samba/smb.conf <<EOF

/### Added by OpenVDM_sample_data install script ###
include = /etc/samba/openvdm_sample_data.conf
/### Added by OpenVDM_sample_data install script ###
EOF

    cat > /etc/samba/openvdm_sample_data.conf <<EOF
# SMB Shares for OpenVDM

[SampleAuthSource]
  comment=Sample Data, read-only non-guest access
  path=${SAMPLE_DATA_ROOT}/auth_source
  browsable = yes
  public = yes
  hide unreadable = yes
  guest ok = no
  writable = no

[SampleAnonSource]
  comment=Sample Data, read-only guest access
  path=${SAMPLE_DATA_ROOT}/anon_source
  browsable = yes
  public = yes
  hide unreadable = yes
  guest ok = yes
  writable = no

[SampleAuthDestination]
  comment=Sample Destination, non-guest access 
  path=${SAMPLE_DATA_ROOT}/auth_destination
  browsable = yes
  public = yes
  hide unreadable = yes
  guest ok = no
  writable = yes
  write list = ${OPENVDM_USER}
  create mask = 0644
  directory mask = 0755
  veto files = /._*/.DS_Store/.Trashes*/
  delete veto files = yes

[SampleAuthDestination]
  comment=Sample Destination, non-guest access 
  path=${SAMPLE_DATA_ROOT}/anon_destination
  browseable = yes
  public = yes
  guest ok = yes
  writable = yes
  create mask = 0000
  directory mask = 0000
  veto files = /._*/.DS_Store/.Trashes*/
  delete veto files = yes
  force create mode = 666
  force directory mode = 777
EOF

    echo "Restarting Samba Service"
    systemctl restart smbd.service
}

function configure_directories {

    if [ ! -d $SAMPLE_DATA_ROOT ]; then
        while true; do
            read -p "Sample data directory ${SAMPLE_DATA_ROOT} does not exists... create it? (yes) " yn
            case $yn in
                [Yy]* )
                    mkdir -p ${SAMPLE_DATA_ROOT}/auth_source
                    mkdir -p ${SAMPLE_DATA_ROOT}/anon_source
                    mkdir -p ${SAMPLE_DATA_ROOT}/auth_destination
                    mkdir -p ${SAMPLE_DATA_ROOT}/anon_destination
                    break;;
                "" )
                    mkdir -p ${SAMPLE_DATA_ROOT}/auth_source
                    mkdir -p ${SAMPLE_DATA_ROOT}/anon_source
                    mkdir -p ${SAMPLE_DATA_ROOT}/auth_destination
                    mkdir -p ${SAMPLE_DATA_ROOT}/anon_destination
                    break;;
                [Nn]* )
                    echo "Quitting"
                    exit_gracefully;;
                * ) echo "Please answer yes or no.";;
            esac
        done
    fi

}

###########################################################################
###########################################################################
# Install OpenVDM
function update_openvdm {
    # Expect the following shell variables to be appropriately set:
    # DATA_ROOT - path where data will be stored is
    # OPENVDM_USER - valid userid
    # OPENVDM_REPO - path to OpenVDM repo
    # OPENVDM_BRANCH - branch of rep to install

    startingDir=${PWD}

    if [ ! -d ~/OpenVDMv2_sample_data ]; then  # New install
        echo "Downloading OpenVDMv2 Sample Data repository"
        cd ~
        git clone -b $OPENVDM_BRANCH $OPENVDM_REPO ./openvdm_sample_data
        # chown ${OPENVDM_USER}:${OPENVDM_USER} ./openvdm_sample_data

    else
        cd ~/openvdm_sample_data

        if [ -e .git ] ; then   # If we've already got an installation
            echo "Updating existing OpenVDMv2 Sample Data repository"
            git pull
            git checkout $OPENVDM_BRANCH
            git pull

        else
            echo "Reinstalling OpenVDMv2 Sample Data from repository"  # Bad install, re-doing
            cd ..
            rm -rf ./openvdm_sample_data
            git clone -b $OPENVDM_BRANCH $OPENVDM_REPO ./openvdm_sample_data
        fi
    fi

    cd ~/openvdm_sample_data


    read -p "Samba Password for ${DEFAULT_OPENVDM_USER}? " OPENVDM_SMBUSER_PASSWD

    DB_EXISTS=`mysqlshow --user=${OPENVDM_USER} --password=${OPENVDM_DATABASE_PASSWORD} OpenVDMv2| grep -v Wildcard`
    if [ $? == 0 ]; then
        sed -e "s|${DEFAULT_SAMPLE_DATA_ROOT}|${SAMPLE_DATA_ROOT}|" ~/openvdm_sample_data/OpenVDMv2_sample_data.sql | \
        sed -e "s/${DEFAULT_OPENVDM_USER}/${OPENVDM_USER}/" | \
        sed -e "s/smb_password/${OPENVDM_SMBUSER_PASSWD}/" | \
        > /tmp/OpenVDMv2_sample_data_custom.sql

        mysql -u ${OPENVDM_USER} -p ${OPENVDM_DATABASE_PASSWORD} <<EOF
USE OpenVDMv2;
source /tmp/OpenVDMv2_sample_data_custom.sql;
flush privileges;
\q
EOF
        rm /tmp/OpenVDMv2_sample_data_custom.sql

    else
        echo "Error: OpenVDMv2 database not found"
        cd ${startingDir}
        exit_gracefully
    fi

    tar xvzf ~/openvdm_sample_data/sample_data.tgz -C ${SAMPLE_DATA_ROOT}

    cd ${startingDir}
}


###########################################################################
###########################################################################
###########################################################################
###########################################################################
# Start of actual script
###########################################################################
###########################################################################

# Read from the preferences file in $PREFERENCES_FILE, if it exists
set_default_variables

if [ "$(whoami)" != "root" ]; then
    echo "ERROR: installation script must be run as root."
    exit_gracefully
fi


echo "#####################################################################"
echo "OpenVDM configuration script"

read -p "OpenRVDAS install root? ($DEFAULT_INSTALL_ROOT) " INSTALL_ROOT
INSTALL_ROOT=${INSTALL_ROOT:-$DEFAULT_INSTALL_ROOT}
echo "Install root will be '$INSTALL_ROOT'"
echo

read -p "Repository to install from? ($DEFAULT_OPENVDM_REPO) " OPENVDM_REPO
OPENVDM_REPO=${OPENVDM_REPO:-$DEFAULT_OPENVDM_REPO}

read -p "Repository branch to install? ($DEFAULT_OPENVDM_BRANCH) " OPENVDM_BRANCH
OPENVDM_BRANCH=${OPENVDM_BRANCH:-$DEFAULT_OPENVDM_BRANCH}

echo "Will install from github.com"
echo "Repository: '$OPENVDM_REPO'"
echo "Branch: '$OPENVDM_BRANCH'"
echo

# Create user if they don't exist yet
echo "#####################################################################"
read -p "OpenVDM user? ($DEFAULT_OPENVDM_USER) " OPENVDM_USER
OPENVDM_USER=${OPENVDM_USER:-$DEFAULT_OPENVDM_USER}
verify_user $OPENVDM_USER

echo
read -p "OpenVDMv2 Database password to use for user $OPENVDM_USER? ($OPENVDM_USER) " OPENVDM_DATABASE_PASSWORD
OPENVDM_DATABASE_PASSWORD=${OPENVDM_DATABASE_PASSWORD:-$OPENVDM_USER}

read -p "Root directory for sample data? ($DEFAULT_SAMPLE_DATA_ROOT) " SAMPLE_DATA_ROOT
SAMPLE_DATA_ROOT=${SAMPLE_DATA_ROOT:-$DEFAULT_SAMPLE_DATA_ROOT}


#########################################################################
#########################################################################
# Save defaults in a preferences file for the next time we run.
save_default_variables

#########################################################################
#########################################################################
# Install packages
echo "#####################################################################"
echo "Installing required software packages and libraries"
install_packages

echo "#####################################################################"
echo "Creating required directories"
configure_directories

echo "#####################################################################"
echo "Configuring Samba"
configure_samba $OPENVDM_USER

echo "#####################################################################"
echo "Configuring Rsync Server"
configure_gearman

echo "#####################################################################"
echo "Updating OpenVDM"
update_openvdm

#########################################################################
#########################################################################
