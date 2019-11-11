#!/bin/bash

source ~/bin/workspaceconfig.sh


containerID=`cat ${WORKSPACE_VIM_YCM_CID}`
sudo docker stop ${containerID}
rm -rf ${WORKSPACE_VIM_YCM_CID}
