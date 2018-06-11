#!/bin/bash

echo 'Configuring cluster blue proxy...'
IP=$(docker-machine ip)
OUTPUT3=$(curl "$IP:8081/v1/docker-flow-proxy/reconfigure?serviceName=demo_cluster-blue&servicePath=/hello&port=3000")
echo $OUTPUT3
echo 'DONE'


echo 'Configuring production proxy...'
IP=$(docker-machine ip)
OUTPUT3=$(curl "$IP:8080/v1/docker-flow-proxy/reconfigure?serviceName=demo_proxy-blue&servicePath=/hello&port=80")
echo $OUTPUT3
echo 'DONE'

echo '¿Qué URLs tenemos ahora?
- http://192.168.99.100:8000/ -> Consola web.
- http://192.168.99.100/hello -> Load balancer del BG deployment apuntando a demo_proxy-blue.
- http://192.168.99.100:81/hello -> Load balancer del servicio demo_cluster-blue.
- http://192.168.99.100:3000/hello -> Acceso directo al servicio demo_cluster-blue, sin load balancer.
'