#!/bin/bash


if [ "$#" -ne 2 ]; then
	echo "Incorrect number of arguments"
	echo "number given "$#
	echo 'number expected is 2'
	echo 'This is the proper format'
	echo './04_switch_bg_proxy.sh blue|green green|blue'
	exit 1
fi

echo 'parametres'
echo '$0 = ' $0
echo 'Old service $1 = ' $1
echo 'New service $2 = ' $2
default='demo_cluster-'
oldSvc=$default$1
newSvc=$default$2
echo $oldService
OUTPUT=$(docker service ls --filter name=$oldSvc|grep $oldSvc)
if [[ $? != 0 ]];then
	echo 'Service '$oldSvc 'not found'
	exit 1
fi
echo $OUTPUT
echo ''
OUTPUT2=$(docker service ls --filter name=$newSvc|grep $newSvc)
if [[ $? != 0 ]];then
	echo 'Service '$2 'not found'
	exit 1
fi
echo $OUTPUT2

echo 'Configuring production proxy...'
IP=$(docker-machine ip)
OUTPUT3=$(curl "localhost:8080/v1/docker-flow-proxy/reconfigure?serviceName=demo_proxy-$2&servicePath=/hello&port=80")
echo $OUTPUT3
OUTPUT4=$(curl "localhost:8080/v1/docker-flow-proxy/remove?serviceName=demo_proxy-$1")
echo $OUTPUT4
echo 'DONE'

echo '¿Qué URLs tenemos ahora?

- http://192.168.99.100:8000/ -> Consola web.
- http://192.168.99.100/hello -> Load balancer del BG deployment apuntando a demo_cluster-green.
- http://192.168.99.100:81/hello -> Load balancer del servicio demo_cluster-blue.
- http://192.168.99.100:3000/hello -<> Acceso directo al servicio demo_cluster-blue, sin load balancer.
- http://192.168.99.100:82/hello -> Load balancer del servicio demo_cluster-green.
- http://192.168.99.100:3001/hello -<> Acceso directo al servicio demo_cluster-green, sin load balancer.
'
