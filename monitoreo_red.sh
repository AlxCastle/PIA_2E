#!/bin/bash 

#Verificar si el comando ifstat está instalado
if ! command -v ifstat &> /dev/null;
then
    echo "Error: ifstat no está instalado. Instálalo para volver a intentar."
    exit 1
fi

#Definir la función para monitorear la red
function network_monitoring {
    local n=$1
    for ((i=1; i<=n; i++)); do
        ifstat 5 1
        sleep 5
    done
}

#Solicitar opción
read -p "Elija una de las siguientes opciones [1]-Ver el monitoreo de red en vivo \
[2]-Ver el monitoreo de red cierta cantidad de veces [3]-Generar el monitoreo de red cierta cantidad de veces: " op

#Validar la opción elegida por el usuario
while ! [[ $op =~ ^[1-3]$ ]]; 
do
    read -p "Ingrese una opción correcta (1, 2 o 3): " op
done
#Se ejecuta la opcion deseada
if [ $op -eq 1 ]; 
then
    # Ver el monitoreo indefinidamente
    echo "Presione Ctrl+C para salir"
    ifstat
elif [ $op -eq 2 ];
then
    #Ver una cantidad definida de veces el monitoreo
    read -p "Ingrese la cantidad de veces que quiere ver el monitoreo: " num
    network_monitoring $num
else 
    #Pedir el nombre del archivo y la cantidad de veces
    read -p "Ingrese el nombre del reporte que quiere generar: " file
    read -p "Ingrese la cantidad de veces que quiere ver el monitoreo: " num
    #redirigir la salida a un archivo
    if ! network_monitoring $num > "$file"; then
        echo "Error: No se pudo generar el archivo"
        exit 1
    else
        echo "El reporte ha sido generado"
    fi
fi
