# 2o Entregable - Proyecto Final de Ciberseguridad: Módulos de Bash y GitHub

## Descripción
Este proyecto consiste en la creación de dos scripts en Bash que realizan tareas de ciberseguridad: `monitoreo de red` y `escaneo de puertos`. 
Los scripts aceptan parámetros de entrada y cuentan con menús interactivos para diversas funcionalidades, así como el manejo de errores durante la ejecución.

## Objetivos
- Desarrollar habilidades en Bash: Aplicar lo aprendido sobre Bash para crear scripts que realicen tareas de ciberseguridad.
- Continuar usando GitHub: Subir el segundo entregable a un repositorio. 

## Tareas
### 1. `monitoreo_red.sh`
Este script permite identificar el trafico ejecutando el monitoreo de la red indefinidamente o con una cantidad establecida, así como generar reportes utilizando `ifstat`.

### 2. `port_scan.sh`
Este script realiza escaneos de puertos TCP y UDP utilizando `nmap`. También ofrece la opción de generar un informe en HTML y analizar los resultados del escaneo, entre otras.

## Requisitos
- Bash shell (disponible en sistemas Unix/Linux).
- Tener instalados los paquetes `ifstat` y `nmap`.

## Instrucciones de Uso
1. **Clona el repositorio en tu máquina local**:
   ```bash
   git clone https://github.com/AlxCastle/PIA_2E.git
   ```
   Ahora cuentas con la carpeta y dichos scripts.

2. **Ejecución de los scripts**:
   - Asegúrate de que los scripts sean ejecutables:
     ```bash
     chmod +x monitoreo_red.sh port_scan.sh
     ```

   - Ejecuta el script de monitoreo de red:
     ```bash
     ./monitoreo_red.sh -n [cantidad]
     ```
     - **Cantidad**: Especifica el número de veces que deseas ver el monitoreo.

   El script mostrará un menú para seleccionar las acciones que deseas realizar, como monitorear el tráfico o generar un reporte.

   - Ejecuta el script de escaneo de puertos:
     ```bash
     ./port_scan.sh [opciones]
     ```
     Opciones disponibles:
      - `-t [IP|dominio]`: Especifica la dirección IP o el dominio a escanear.
      - `-p [rango_de_puertos]`: Especifica el rango de puertos a escanear (ejemplo: 1-1000).
      - `-r`: Genera automáticamente un informe HTML después del escaneo.
      - `-u`: Realiza un escaneo de puertos UDP en lugar de TCP.

   Este script también presenta un menú interactivo para configurar el escaneo y generar reportes si no se incluyen parámetros de entrada.

## Ejemplos

### Ejemplo 1: Escaneo de Puertos con Informe Automático
```bash
./port_scan.sh -t 10.0.0.5 -p 1-500 -r
```
Este comando escaneará los puertos TCP del host `10.0.0.5` en el rango del 1 al 500 y generará automáticamente un informe HTML.

### Ejemplo 2: Monitoreo de Red con Cantidades Especificadas 
```bash
./monitoreo_red.sh -n 10
```
Ejecuta 10 veces el monitoreo de red.

## Demostración
Puedes ver un video sobre cómo funcionan los scripts aquí: https://youtu.be/mUHukhCl_4g

## Colaboradores
Este proyecto fue desarrollado en colaboración con:
- Emilio Rafael Puente Cardona 
- Manuel Emilio Delgado Gómez
- Alondra Castillo Gonzalez
