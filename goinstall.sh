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

if  [ "uname -a | grep Ubuntu" ];then
    #for Ubuntu
    dlcmd="apt-get -y"
    homedir="/home/$1"
else
    os=`uname`
    if [ $os = "Linux" ]; then 
        #for Red Hat System (Cent OS,  Fedora etc...)
        dlcmd="yum -y"
        homedir="/home/$1"
    elif [ $os = "Darwin" ]; then
        #for Mac
        if  ! type >/dev/null "port" 2>&1 ; then
            echo "You need to install Xcode and gcc."
            exit 1
        fi
        dlcmd="port"
        homedir="/Users/$1"
    else
        echo "not Linux or Mac"
        exit 1
    fi
fi

# Install gcc
if  ! type >/dev/null "gcc" 2>&1 ; then
    echo "Installing gcc ..." 
    $dlcmd install gcc
    echo "Done"
else
    echo "gcc is installed."
fi

# Install Marcurial
if  ! type >/dev/null "hg" 2>&1 ; then
    echo "Installing Mercurial ..." 
    $dlcmd install mercurial
    echo "Done"
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
    . ./all.bash
    echo "Done"
else
    echo "executed ./all.bash"
fi

# Set System variables
cd $homedir
. ./gosetting.sh $1

echo ""
echo "ALL DONE"
echo ""
