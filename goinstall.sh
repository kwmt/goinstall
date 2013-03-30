#!/bin/sh 
# Copyright 2013 Yasutaka Kawamoto. All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.

# const 
installdir="/usr/local/go"

# check arg
Document="usage: sudo ./goinstall.sh login_user"
if [ $# -lt 1 ];then
   echo "$Document"
   exit 1
fi


# Check whether go is installed.
if  [ ! -f $installdir/bin/go ]; then
    echo "go is not Installed. Continue..."
else
    echo "Go is installed."
    echo "Exit."
    #exit 1
fi

#Check OS
if [ -f /etc/lsb-release ]; then
    . /etc/lsb-release
    dlcmd="apt-get -y"
    homedir="/home/$1"
elif [ -f /etc/debian_version ]; then
    dlcmd="apt-get -y"
    homedir="/home/$1"
elif [ -f /etc/redhat-release ]; then
    dlcmd="yum -y"
    homedir="/home/$1"
elif [ -f /etc/system-release ]; then
    dlcmd="yum -y"
    homedir="/home/$1"
elif [ `uname` = "Darwin" ]; then #for Mac
    homedir="/Users/$1"
else
    echo "not Linux or Mac"
    exit 1
fi


# Install gcc
if  ! type >/dev/null "gcc" 2>&1 ; then
    if [ `uname` = "Darwin" ]; then #for Mac
        echo "You need to install Xcode and gcc."
        exit 1
    else
        echo "Installing gcc ..." 
        $dlcmd install gcc
        echo "Done"
    fi
else
    echo "gcc is installed."
fi

# Install Marcurial
if  ! type >/dev/null "hg" 2>&1 ; then
    if [ `uname` = "Darwin" ]; then #for Mac
        echo "You need to install Marcurial."
        echo "http://mercurial.selenic.com/downloads/"
        exit 1
    else
        echo "Installing Mercurial ..." 
        $dlcmd install mercurial
        echo "Done"
    fi
else
    echo "Mercurial is installed."
fi

# Install Go
if [ -d $installdir ]
then 
    echo "go dir is existed."
else
    echo "downloading go ..."
    `hg clone -u release https://code.google.com/p/go $installdir`
    echo "Done"
fi

#echo "move directory to go/src."
cd $installdir/src/
echo `pwd`
if  ! [  -d $installdir/bin -a -d $installdir/pkg ]; then
    echo "executing ./all.bash ..."
    { . ./all.bash; }
    echo "Done"
else
    echo "executed ./all.bash"
fi

# Set environment variables
cd $homedir
{ . ./gosetting.sh $1; }

echo ""
echo "ALL DONE"
echo ""
