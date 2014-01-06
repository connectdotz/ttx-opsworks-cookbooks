#!/bin/bash

mkdir -p ~/bin

cat >> ~/.bashrc << EOF 
set -o vi
alias cd-ops-log="cd /var/lib/aws/opsworks/chef"
alias cd-ops-cookbooks="cd /opt/aws/opsworks/current/site-cookbooks/"

PATH=./:~/bin:$PATH

EOF

source ~/.bashrc
