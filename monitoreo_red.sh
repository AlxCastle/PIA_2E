#!/bin/bash 

#Check if the ifstat command is installed
if ! command -v ifstat &> /dev/null;
then
    echo "Error: ifstat no está instalado. Instálalo para volver a intentar."
    exit 1
fi

#Define the function to monitor the network
function network_monitoring {
    local n=$1
    for ((i=1; i<=n; i++)); do
        ifstat 5 1
        sleep 5
    done
}

#Request option
read -p "Elija una de las siguientes opciones [1]-Ver el monitoreo de red en vivo \
[2]-Ver el monitoreo de red cierta cantidad de veces [3]-Generar el monitoreo de red cierta cantidad de veces: " op

#Validate the option chosen by the user
while [ $op -ne 1 ] && [ $op -ne 2 ] && [ $op -ne 3 ]; 
do
    read -p "Ingrese una opción correcta (1, 2 o 3): " op
done

#The desired option is executed
if [ $op -eq 1 ]; 
then
    #View monitoring indefinitely
    echo "Presione Ctrl+C para salir"
    ifstat
elif [ $op -eq 2 ];
then
    #View a defined number of monitoring times
    read -p "Ingrese la cantidad de veces que quiere ver el monitoreo: " num
    network_monitoring $num
else 
    #Prompt for file name and number of times
    read -p "Ingrese el nombre del reporte que quiere generar: " file
    read -p "Ingrese la cantidad de veces que quiere ver el monitoreo: " num
    #redirect output to a file
    if ! network_monitoring $num > "$file"; 
    then
        echo "Error: No se pudo generar el archivo"
        exit 1
    else
        echo "El reporte ha sido generado"
    fi
fi
