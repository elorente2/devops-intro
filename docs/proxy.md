# Set up PROXY

1. Copiar el archivo _set_local_cygwin_env.sh_ en la carpeta de instalación de Docker Toolbox (por defecto, %PROGRAMFILES%/Docker Toolbox/)

2. Editar el archivo _start.sh_ en la linea 4, debe quedar cómo a continuación
```
#!/bin/bash

trap '[ "$?" -eq 0 ] || read -p "Looks like something went wrong in step ´$STEP´... Press any key to continue..."' EXIT
. set_local_cygwin_env.sh

[...]
```

3. A partir de ahora, cada vez que iniciemos docker, se nos configurará el proxy correctamente.