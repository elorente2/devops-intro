Abrimos la Docker Quickstart Terminal

Ejecutamos el siguiente comando para obtener el codigo necesario para llevar a cabo la demo

	$ git clone https://github.com/MarcSolde/docker-swarm-BGdeplo-demo.git && cd docker-swarm-BGdeplo-demo/Src/scripts
	
Ejecutamos el comando
	
	$./01_create_infraestructure.sh
	
Los servicios deployados son los siguientes

	- demo_proxy  -> Proxy de producción
	- demo_proxy-blue -> Proxy para el servicio demo_cluster-blue
	- demo_proxy-green -> Proxy para el (futuro) servicio green
	- demo_swarm-listener -> Servicio que se encarga de avisar a demo_proxy cuando aparece o desaparece un servicio (mediante la captura de eventos de Swarm)
	- demo_console -> Consola web
	- demo_cluster-blue -> Servicio blue

Para comprobar el estado del deploy, ejecutamos el siguiente comando
	
	$ docker service ls

0. Cuando todos los servicios estén _deployados_, ejecutaremos el siguiente script
	
	`$ ./02_setup_routing.sh`
	* Habilita el acceso al servicio demo_cluster-blue por el puerto 3000 y por el proxy productivo. En la consola se puede visualizar el acceso al clúster por el "Production cluster" es correcto.

	* Habilita el acceso balanceador del servicio demo_cluster-blue entre sus diferentes instancias. En la consola se puede visualizar que el acceso por el "Clúster blue" es correcto.

¿Qué URLs tenemos ahora?
	
	- http://192.168.99.100:8000/ -> Consola web.
	- http://192.168.99.100/hello -> Load balancer del BG deployment apuntando a demo_cluster-blue.
	- http://192.168.99.100:81/hello -> Load balancer del servicio demo_cluster-blue.
	- http://192.168.99.100:3000/hello -<> Acceso directo al servicio demo_cluster-blue, sin load balancer.

A continuación vamos a llevar a cabo un BG Deployment, mediante los siguientes pasos
	
1. Creamos una copia de la carpeta App-hello-world 
2. Editamos el _server.js_ (Para poder indentificar las distintas versiones) y añadimos el siguiente alias:

	`$ alias docker_build='docker build --build-arg HTTP_PROXY=http://jeverisDeveloper:jeverisDeveloper@10.110.8.42:8080'`
3. Creamos la nueva imagen de docker mediante

	`$ docker_build -t marcsolde/demo-app:v2 .`

4. Ejecutaremos el siguiente script

	`$ ./03_setup_service_and_routing_green.sh`
	
	* Crea el servicio green con la imágen marcsolde/demo-app:v2
	
	* Habilita el acceso balanceador del servicio demo_cluster-green entre sus diferentes instancias. En la consola se puede visualizar que el acceso por el "Clúster green" es correcto.

¿Qué URLs tenemos ahora?

	- http://192.168.99.100:8000/ -> Consola web.
	- http://192.168.99.100/hello -> Load balancer del BG deployment apuntando a demo_cluster-blue.
	- http://192.168.99.100:81/hello -> Load balancer del servicio demo_cluster-blue.
	- http://192.168.99.100:3000/hello -<> Acceso directo al servicio demo_cluster-blue, sin load balancer.
	- http://192.168.99.100:82/hello -> Load balancer del servicio demo_cluster-green.
	- http://192.168.99.100:3001/hello -<> Acceso directo al servicio demo_cluster-green, sin load balancer.

5. Ejecutaremos el _script_ bg-magic.sh_ con el formato para llevar a cabo el Blue Green Deployment

	`$ ./04_switch_bg_proxy.sh blue|green green|blue`

En nuestro caso sería

	$ ./04_switch_bg_proxy.sh blue green

¿Qué URLs tenemos ahora?
	
	- http://192.168.99.100:8000/ -> Consola web.
	- http://192.168.99.100/hello -> Load balancer del BG deployment apuntando a demo_cluster-green.
	- http://192.168.99.100:81/hello -> Load balancer del servicio demo_cluster-blue.
	- http://192.168.99.100:3000/hello -<> Acceso directo al servicio demo_cluster-blue, sin load balancer.
	- http://192.168.99.100:82/hello -> Load balancer del servicio demo_cluster-green.
	- http://192.168.99.100:3001/hello -<> Acceso directo al servicio demo_cluster-green, sin load balancer.

6. Estos cambios los podemos ver a tiempo real en la consola web

7. Si deseamos escalar cualquier servicio:

	$ docker service scale $SVC_NAME=#Replicas

Para eliminar-lo todo, ejecutaremos el siguiente script
	
	$ ./10_remove_all.sh
