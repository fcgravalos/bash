#!/bin/bash


########################################################################################################
# File: networkingtool.sh                                                                              #
# Description: Bash Toolkit that provides network information and network scanning for Unix Platforms. #
# Author: Fernando Crespo Grávalos (fcgravalos@gmail.com)                                              #
# Version: 0.0.1                                                                                       #
# Creation Date: 2015-01-19                                                                            #
# Modified Date: 2015-01-19                                                                            #
########################################################################################################
#############
# Constants #
#############
## Date ##
DATE=$(date +'%Y-%m-%d:%H:%M:%S')
## Unix OS ##
LINUX="Linux"
AIX="AIX"
MAC_OS_X="Mac Os X"

## Link Encapsulation Type ##
ETHERNET="Ethernet"
LOOPBACK="Local Loopback"

##################################
# Network Information Functions  #
##################################

# Return Network Interface Name
# $1: UNIX version
# $2 : Link encapsulation
function getNetworkInterface() {
    UNIX_OS=$1
    LINK_ENCAP=$2

    if [[ $LINK_ENCAP != $ETHERNET && $LINK_ENCAP != $LOOPBACK ]]; then
      echo "$DATE [ERROR] Link encapsulation not recognized: $LINK_ENCAP. Expected: $ETHERNET or $LOOPBACK."
      exit -1
    fi

    if [ $UNIX_OS==$LINUX ]; then
      ifconfig | grep -i "Link encap:$LINK_ENCAP" | awk '1 {print $1}'
    fi
}

function getIp() {
  NET_IFACE=$1
  ifconfig $NET_IFACE | grep -i "inet addr" | awk '1 {print $2}' | cut -d : -f 2
}

iface=$(getNetworkInterface Linux Ethernet)
ip=$(getIp $iface)