#!/bin/bash
# Program:
#       This program launch web app via command
#
#Copyright (c) 2013 Intel Corporation.
#
#Redistribution and use in source and binary forms, with or without modification,
#are permitted provided that the following conditions are met:
#
#* Redistributions of works must retain the original copyright notice, this list
#  of conditions and the following disclaimer.
#* Redistributions in binary form must reproduce the original copyright notice,
#  this list of conditions and the following disclaimer in the documentation
#  and/or other materials provided with the distribution.
#* Neither the name of Intel Corporation nor the names of its contributors
#  may be used to endorse or promote products derived from this work without
#  specific prior written permission.
#
#THIS SOFTWARE IS PROVIDED BY INTEL CORPORATION "AS IS"
#AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
#IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
#ARE DISCLAIMED. IN NO EVENT SHALL INTEL CORPORATION BE LIABLE FOR ANY DIRECT,
#INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
#BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
#DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY
#OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
#NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
#EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
# Author:
#        IVAN CHEN <yufeix.chen@intel.com>
#

local_path=$(cd $(dirname $0);pwd)
source $local_path/Common
xpk_path=$local_path/../testapp

func_check_xwalkservice

# install original xpk
pkgid=`pkgcmd -l | grep "diffid_same_version_tests" | awk '{print $4}'`
pkgid=`echo $pkgid | awk '{print $1}'`
pkgid=${pkgid:1:-1}
get_uninstall=`pkgcmd -u -n  $pkgid -q`

pkgcmd -i -t xpk -p $xpk_path/diffid_same_version_tests.xpk -q

app_id=`app_launcher -l | grep "diffid_same_version_tests" | head -n 1| awk  '{print $2}'`
app_id=${app_id:1:-1}
app_launcher -s $app_id 
sleep 2
pkgid=`pkgcmd -l | grep "diffid_same_version_tests" | awk '{print $4}'`
pkgid=`echo $pkgid | awk '{print $1}'`
pkgid=${pkgid:1:-1}
#install xwalk web app
pkgcmd -u -n  $pkgid -q
if [[ $? -eq 0 ]]; then
                echo "Uninstall Pass"
                exit 0
        else
                echo "Uninstall Fail"
                exit 1
fi
