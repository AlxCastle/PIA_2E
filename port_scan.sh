#!/bin/bash

# Variables por defecto
target=""
port_range=""
auto_generate_report=false
scan_udp=false  # Variable para activar escaneo UDP

# Función para manejar errores
handle_error() {
    echo "Ocurrió un error inesperado. Verifica los parámetros de entrada e intenta de nuevo."
    exit 1
}

# Atrapar señales de error como SIGINT (Ctrl+C)
trap handle_error ERR

# Función para escanear puertos TCP usando nmap
scan_ports_tcp() {
    if [ -z "$target" ] || [ -z "$port_range" ]; then
        read -p "Ingresa la IP o dominio a escanear: " target
        read -p "Ingresa el rango de puertos a escanear (ejemplo: 1-1000): " port_range
    fi

    # Obtener la fecha y hora actual
    timestamp=$(date '+%Y-%m-%d %H:%M:%S')

    echo "Escaneando puertos TCP en $target..."

    # Añadir encabezado de resultados directamente al archivo scan_results.txt
    echo "===== ESCANEO TCP: $timestamp =====" >> scan_results.txt
    echo "Objetivo: $target" >> scan_results.txt
    echo "Rango de puertos: $port_range" >> scan_results.txt
    echo "--------------------------------" >> scan_results.txt

    # Ejecutar nmap y capturar la salida
    nmap_output=$(nmap -p $port_range -T4 $target)

    if [ $? -eq 0 ]; then
        echo "$nmap_output" >> scan_results.txt

        # Buscar los puertos abiertos y cerrados
        open_ports=$(echo "$nmap_output" | grep -oP '\d+/tcp\s+open' | awk '{print $1}')
        closed_ports=$(echo "$nmap_output" | grep -oP '\d+/tcp\s+closed' | awk '{print $1}')

        # Mostrar los resultados en la consola y añadir al reporte
        if [ -z "$open_ports" ]; then
            echo "No se encontraron puertos TCP abiertos en $target." >> scan_results.txt
            echo "No se encontraron puertos TCP abiertos en $target."
        else
            echo "Puertos TCP abiertos en $target: $open_ports" >> scan_results.txt
            echo "Puertos TCP abiertos en $target: $open_ports"
        fi

        if [ -z "$closed_ports" ]; then
            echo "No se encontraron puertos TCP cerrados en $target." >> scan_results.txt
            echo "No se encontraron puertos TCP cerrados en $target."
        else
            echo "Puertos TCP cerrados en $target: $closed_ports" >> scan_results.txt
            echo "Puertos TCP cerrados en $target: $closed_ports"
        fi
    else
        echo "El escaneo falló. Verifica la IP/Dominio o rango de puertos." >> scan_results.txt
        echo "El escaneo falló. Verifica la IP/Dominio o rango de puertos."
    fi

    echo "================================" >> scan_results.txt
    echo "" >> scan_results.txt

    if [ "$auto_generate_report" = true ]; then
        generate_report
    fi

    target=""
    port_range=""
}

# Función para escanear puertos UDP usando nmap
scan_ports_udp() {
    if [ -z "$target" ] || [ -z "$port_range" ]; then
        read -p "Ingresa la IP o dominio a escanear: " target
        read -p "Ingresa el rango de puertos UDP a escanear (ejemplo: 1-1000): " port_range
    fi

    timestamp=$(date '+%Y-%m-%d %H:%M:%S')

    echo "Escaneando puertos UDP en $target..."

    echo "===== ESCANEO UDP: $timestamp =====" >> scan_results.txt
    echo "Objetivo: $target" >> scan_results.txt
    echo "Rango de puertos UDP: $port_range" >> scan_results.txt
    echo "--------------------------------" >> scan_results.txt

    nmap_output=$(nmap -sU -p $port_range -T4 $target)

    if [ $? -eq 0 ]; then
        echo "$nmap_output" >> scan_results.txt

        open_ports=$(echo "$nmap_output" | grep -oP '\d+/udp\s+open' | awk '{print $1}')
        closed_ports=$(echo "$nmap_output" | grep -oP '\d+/udp\s+closed' | awk '{print $1}')

        if [ -z "$open_ports" ]; then
            echo "No se encontraron puertos UDP abiertos en $target." >> scan_results.txt
            echo "No se encontraron puertos UDP abiertos en $target."
        else
            echo "Puertos UDP abiertos en $target: $open_ports" >> scan_results.txt
            echo "Puertos UDP abiertos en $target: $open_ports"
        fi

        if [ -z "$closed_ports" ]; then
            echo "No se encontraron puertos UDP cerrados en $target." >> scan_results.txt
            echo "No se encontraron puertos UDP cerrados en $target."
        else
            echo "Puertos UDP cerrados en $target: $closed_ports" >> scan_results.txt
            echo "Puertos UDP cerrados en $target: $closed_ports"
        fi
    else
        echo "El escaneo UDP falló. Verifica la IP/Dominio o rango de puertos." >> scan_results.txt
        echo "El escaneo UDP falló. Verifica la IP/Dominio o rango de puertos."
    fi

    echo "================================" >> scan_results.txt
    echo "" >> scan_results.txt

    if [ "$auto_generate_report" = true ]; then
        generate_report
    fi

    target=""
    port_range=""
}

# Función para generar un reporte en HTML
generate_report() {
    if [ ! -f scan_results.txt ]; then
        echo "No hay resultados de escaneo. Realiza un escaneo primero."
        return
    fi
    echo "Generando reporte..."
    echo "<html><body><h1>Reporte de Escaneo de Puertos</h1><pre>" > report.html
    cat scan_results.txt >> report.html
    echo "</pre></body></html>" >> report.html
    echo "Reporte generado: report.html"
}

# Función para analizar los resultados del escaneo
analyze_results() {
    if [ ! -f scan_results.txt ]; then
        echo "No hay resultados de escaneo. Realiza un escaneo primero."
        return
    fi
    echo "Analizando resultados..."
    open_ports=$(grep -oP 'open' scan_results.txt | wc -l)
    closed_ports=$(grep -oP 'closed' scan_results.txt | wc -l)
    echo "Puertos abiertos: $open_ports"
    echo "Puertos cerrados: $closed_ports"
}

# Función para limpiar resultados previos
clear_results() {
    rm -f scan_results.txt report.html
    echo "Resultados anteriores eliminados."
}

# Función para mostrar el menú
show_menu() {
    echo ""
    echo "======= MENÚ ======="
    echo "1. Escanear puertos TCP"
    echo "2. Escanear puertos UDP"
    echo "3. Generar reporte en HTML"
    echo "4. Analizar resultados"
    echo "5. Limpiar resultados"
    echo "6. Salir"
    echo "===================="
}

# Procesar parámetros de entrada
while getopts ":t:p:ru" opt; do
    case $opt in
        t) target="$OPTARG" ;; # IP o dominio objetivo
        p) port_range="$OPTARG" ;; # Rango de puertos
        r) auto_generate_report=true ;; # Generar reporte automáticamente
        u) scan_udp=true ;; # Activar escaneo UDP
        \?)
            echo "Opción no válida: -$OPTARG" >&2
            exit 1
            ;;
    esac
done

# Verificar si se dieron parámetros de entrada
if [ -n "$target" ] && [ -n "$port_range" ]; then
    if [ "$scan_udp" = true ]; then
        scan_ports_udp
    else
        scan_ports_tcp
    fi
    exit 0
fi

# Loop principal del menú si no hay parámetros de entrada
while true; do
    show_menu
    read -p "Elige una opción: " choice
    case $choice in
        1)
            scan_ports_tcp
            ;;
        2)
            scan_ports_udp
            ;;
        3)
            generate_report
            ;;
        4)
            analyze_results
            ;;
        5)
            clear_results
            ;;
        6)
	    echo "Saliendo..."
            exit 0
            ;;
        *)
            echo "Opción no válida, intenta de nuevo."
            ;;
    esac
done

