#!/bin/bash

source ~/bin/workspaceconfig.sh

EnterVimYCM()
{
	containerID=`cat ${WORKSPACE_VIM_YCM_CID}`
	sudo docker exec -it ${containerID} bash
}

RestartVimYCM()
{   
	containerID=`cat ${WORKSPACE_VIM_YCM_CID}`
	sudo docker stop ${containerID}
	StartVimYCM
}

StartVimYCM()
{
	rm -rf ${WORKSPACE_VIM_YCM_CID}
	sudo docker run \
	    --env GOPATH=${GOPATH} \
		--env PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/vim/bin:/root/bin" \
		--volume ${GOPATH}:${GOPATH} \
		--workdir ${WORKSPACE_VIM_YCM_WORKDIR} \
		-itd --rm --cidfile ${WORKSPACE_VIM_YCM_CID} ${WORKSPACE_VIM_YCM_IMAGE} bash
	containerID=`cat ${WORKSPACE_VIM_YCM_CID}`
	sudo docker cp ~/.vim/plugin ${containerID}:${WORKSPACE_VIM_CONFIG}
	sudo docker cp ~/bin/ ${containerID}:${WORKSPACE_BIN_CONFIG}
	sudo docker cp ~/.ssh/id_rsa ${containerID}:/root/.ssh/
	sudo docker cp ~/.ssh/id_rsa.pub ${containerID}:/root/.ssh/
	EnterVimYCM
}

CheckVimYCM()
{
	if [ ! -f "${WORKSPACE_VIM_YCM_CID}" ]; then
		StartVimYCM
		return
	fi
	containerID=`cat ${WORKSPACE_VIM_YCM_CID}`
	if [ "x${containerID}" = "x" ]; then
		StartVimYCM
		return
	fi
	res=`sudo docker inspect -f '{{.State.Running}}' ${containerID}`
	if [ "x${res}" != "xtrue" ]; then
		RestartVimYCM
		return
	fi
	EnterVimYCM
	return
}

sudo systemctl start docker
CheckVimYCM
