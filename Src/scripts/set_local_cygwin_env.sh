#!/bin/bash

shopt -s expand_aliases

function __check_host_connection() {
	local host=$1
	ping -n 1 ${host} 2>&1 > /dev/null
	rc=$?
	return ${rc}
}

function __set_proxy() {
	local proxy=$1
	export HTTP_PROXY="${proxy}"
	export HTTPS_PROXY="${proxy}"
	export FTP_PROXY="${proxy}"
	#export NO_PROXY=localhost
	export NO_PROXY="192.168.99.100"
}

function __set_proxy_if_ping_success() {

	local host=$1
	local proxy=$2
	local proxy_docker=$3
	if __check_host_connection ${host}; then 
		__set_proxy "${proxy}"
		return 0
	fi
	return 1
}

# Conexión directa (por defecto)

__set_proxy ""

# everis

[[ -z "${HTTP_PROXY}" ]] && __set_proxy_if_ping_success "proxyeur.everis.int" "http://10.110.8.42:8080" "10.110.8.42:8080"
echo "Proxy set to: ${HTTP_PROXY}"

#[[ ! -z "${HTTP_PROXY}" ]] && __set_docker_build_proxy 
