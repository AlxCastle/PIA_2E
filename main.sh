#!/bin/bash

# Funcion para el menu de cada tarea
submenu(){
    local function=$1
    #local execute_function=$2
    #local execute_report=$3
    
    sleep 2 
    clear
    echo "Submenú: $function"
    PS3="Ingresa una opción: "
    sub_options=("Generar reporte" "Volver a realizar la tarea" "Tarea complementaria" "Regresar")

    select sub_option in "${sub_options[@]}"; do
        case $sub_option in
            "Generar reporte")
                echo "1"
            ;;
            "Volver a realizar la tarea")
                echo "2"
            ;;
            "Tarea complementaria") 
                echo "3"
            ;;
            "Regresar")
                echo "Regresando al menú principal, a continuación presionar ENTER"
                break
            ;;
            *)
                echo "Respuesta inválida $REPLY"
            ;;
	esac
    done 
}

PS3="Selecciona una opción: "
options=("Monitoreo de red" "Escaneo de puertos" "Salir")

clear
echo -e "**MENU PRINCIPAL**\n"
select option in "${options[@]}"; do
    case $option in
        "Monitoreo de red")
            # Ejecución del script
            echo "1"
            submenu "${option}"
        ;;
        "Escaneo de puertos")
            echo "2"
            # Ejecución del sc1ript
	    submenu "${option}"
        ;;
        "Salir")
            echo "Saliendo..."
            break
        ;;
        *)
            echo "Respuesta inválida $REPLY"
        ;;
    esac
done
