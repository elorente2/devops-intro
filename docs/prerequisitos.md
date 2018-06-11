Instalación y puesta a punto de Docker (Windows)

Instalamos Docker toolbox (Nos instalará también git i VBox, recomendamos que, a ser posible, eliminemos VBox si ya lo tubieramos instalado en nuestro sistema antes de instalar Docker toolbox. En caso de error tras la instalación, también puede ser necesario reinstalar el producto habilitando la opción de usar el driver NDIS5 para VBox)

https://www.docker.com/products/docker-toolbox
	
	- ¿Porque Docker Toolbox y no Docker for Windows?
		Si bien es cierto que desde hace poco ha aparecido Docker for Windows, que ejecuta el entorno de Docker nativamente en Windows, tan solo está disponible para W10 Professional o Enterprise 64-bit; por lo que en esta guía usaremos Docker Toolbox, que ejecuta Docker en una imágen de linux preparada para esta función, boot2docker.

Ejecutamos la Docker Quickstart Terminal

 Si tenemos un error del tipo timeout al descargar la imágen de boot2docker debemos editar el archivo start.sh que se encuentra en $DOCKER_TOOLBOX_INSTALL_LOCATION/start.sh y añadir lo siguiente despúes de la linea 3 (trap [...])
	export PROXY=http://IP_PROXY:PUERTO_PROXY
	export HTTP_PROXY=$PROXY
	export HTTPS_PROXY=$PROXY

Para comprobar que todo funciona correctamente, ejecutamos el seguiente comando
	$ docker run hello-world
Si todo ha funcionado correctamente, obtendremos este output
	Hello from Docker!
This message shows that your installation appears to be working correctly.

To generate this message, Docker took the following steps:
 1. The Docker client contacted the Docker daemon.
 2. The Docker daemon pulled the "hello-world" image from the Docker Hub.
 3. The Docker daemon created a new container from that image which runs the
    executable that produces the output you are currently reading.
 4. The Docker daemon streamed that output to the Docker client, which sent it
    to your terminal.

To try something more ambitious, you can run an Ubuntu container with:
 $ docker run -it ubuntu bash

Share images, automate workflows, and more with a free Docker Hub account:
 https://hub.docker.com

For more examples and ideas, visit:
 https://docs.docker.com/engine/userguide/

(Los errores documentados a continuación sólo deberían darse en el caso de crear una nueva máquina virtual para ejecutar otra instancia de docker)

 	- ¿Que hacer si nos encontramos detras de un proxy corporativo?
 		Obviamente si estamos detras un proxy corporativo, el anterior comando fallará, ya que al no tener la imágen hello-world, docker intentará descargarla, y no lo conseguirá por culpa del proxy (T/O)

 		- ¿Cómo arreglamos este problema?
 			Primero de todo nos interesará saber la ip interna de nuestra máquina virtual que ejecuta el entorno Docker; lo conseguiremos mediante el siguiente comando.
 				$ docker-machine ip [default]

 			(Asumiremos que la ip de nuestra máquina es la que obtenemos por defecto, 192.168.99.100)
 			A continuación, crearemos las siguientes variables de entorno.

				$ export HTTP_PROXY=http://proxyIP:proxyPORT

				$ export NO_PROXY=192.168.99.100

			Finalmente, nos conectaremos a nuestra máquina virtual mediante:
				$ docker-machine ssh [default]

			Una vez conectados a la máquina, ejecutaremos lo siguiente
				$ sudo -s
				$ echo "export HTTP_PROXY=http://user:password@proxyIP:proxyPORT" >> /var/lib/boot2docker/profile
				$ echo "export HTTPS_PROXY=http://user:password@proxyIP:proxyPORT" >> /var/lib/boot2docker/profile
				
			(Si queremos comprovar que lo hemos hecho bien, ejecutamos lo siguiente)
				$ cat /var/lib/boot2docker/profile

			Nos desconectaremos de la máquina virtual y la reiniciaremos mediante
				$ docker-machine restart [default]

			Una vez reiniciada, podremos volver a ejecutar el comando para descargar la imágen hello-world, y lo conseguirá sin problemas.
