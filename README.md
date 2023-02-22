# Prueba técnica Backend Developer
Prueba tecnica para backend developer

## Entorno
El entorno está configurado con docker utilizando Makefile para simplificar los comandos de inicio. Para arrancar el proyecto ejecutar el comando:

    make env=dev up

### Servicios levantados en el entorno
En la infraestructura se levantan 3 servicios: 
    Mysql:8 no abierto
    phpmyadmin abierto al puerto 8080
    backend (contiene el código en Symfony) abierto el al puerto 80

### Conectar al contenedor de la aplicación
Para poder ejecutar comandos dentro del entorno hay que conectarse al contenedor que está ejecutándose en docker. Para conectar al cotenedor ejecutamos el comando:

    make env=dev c=backend connect

## Prueba: HealthyFood
Crea una aplicación que permita gestionar recetas. Las recetas tendrán los campos Id, Nombre, Foto, Descripción y Preparación.
El usuario debería poder ver una interfaz en la que gestionar las recetas que se han creado, editar o eliminar.

### Punto extra:
Maqueta los formularios y listas con **Bootstrap** o **Tailwind**, Agrega un login de usuario, crea una función de compartir por whatsapp.
