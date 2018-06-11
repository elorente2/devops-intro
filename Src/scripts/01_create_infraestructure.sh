#!/bin/bash

#Creacion del swarm
echo 'Creamos el swarm'
docker swarm init --advertise-addr $(docker-machine ip)

#Creacion de las networks
echo 'Creamos la network balancers-network'
docker network create --driver overlay balancers-network
echo 'Creamos la internal-network'
docker network create --driver overlay internal-network

#Deploy de los stack
echo 'Creamos los distintos servicios'
docker stack deploy -c docker-stack-demo.yml demo

