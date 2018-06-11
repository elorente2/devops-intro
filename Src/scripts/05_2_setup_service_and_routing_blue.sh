#!/bin/bash

docker service rm demo_cluster-green

docker service create --name demo_cluster-green --network balancers-network --network internal-network --replicas 3 --env DOCKER_SERVICE_NAME=green -p 3001:3000 marcsolde/demo-app:v3

echo 'Configuring cluster green proxy...'
IP=$(docker-machine ip)
OUTPUT3=$(curl "$IP:8082/v1/docker-flow-proxy/reconfigure?serviceName=demo_cluster-green&servicePath=/hello&port=3000")
echo $OUTPUT3
echo 'DONE'
echo '¿Qué URLs tenemos ahora?
- http://192.168.99.100:8000/ -> Consola web.
- http://192.168.99.100/hello -> Load balancer del BG deployment apuntando a demo_cluster-blue.
- http://192.168.99.100:81/hello -> Load balancer del servicio demo_cluster-blue.
- http://192.168.99.100:3000/hello -<> Acceso directo al servicio demo_cluster-blue, sin load balancer.
- http://192.168.99.100:82/hello -> Load balancer del servicio demo_cluster-green.
- http://192.168.99.100:3001/hello -<> Acceso directo al servicio demo_cluster-green, sin load balancer.'