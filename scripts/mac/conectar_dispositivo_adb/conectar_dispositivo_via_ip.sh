#!/bin/bash

# Verificar si adb está instalado
if ! command -v adb &> /dev/null; then
  echo "Error: adb no está instalado."
  echo "Por favor, instala adb antes de continuar."
  exit 1
fi

# Función para mostrar la ayuda
show_help() {
  echo "Uso: $0 [opciones]"
  echo "Opciones:"
  echo "  -h, --help    Muestra esta ayuda"
  echo "  -p, --port    Especifica el puerto TCP/IP (predeterminado: 5555)"
}

# Por defecto, el puerto se establece en 5555
port=5555

# Analizar argumentos de línea de comandos
while [[ $# -gt 0 ]]; do
  case "$1" in
    -h|--help)
      show_help
      exit 0
      ;;
    -p|--port)
      port="$2"
      shift 2
      ;;
    *)
      echo "Opción no válida: $1"
      show_help
      exit 1
      ;;
  esac
done

# Verifica si hay dispositivos Android conectados
if adb devices | grep -q "device$"; then
  echo "Iniciando el script..."
  echo "Configurando el puerto TCP/IP en $port"
  # Si hay dispositivos, configura el puerto TCP/IP
  adb tcpip "$port"
  echo "Esperando para que el dispositivo esté listo..."  
  # Espera unos segundos para que el dispositivo esté listo
  sleep 2

  echo "Desconecta el dispositivo de la pc"  

  sleep 2

  # Obtiene la dirección IP del dispositivo
  device_ip=$(adb shell ip route | awk '{print $9}')
  

  # Verificar si la dirección IP está vacía o nula
  if [ -z "$device_ip" ]; then
   echo "El dispositivo no está conectado a la red o no se pudo obtener la dirección IP."
   echo "**El SCRIPT NO FINALIZO**"
   exit 1
  fi

  echo "Dirección IP del dispositivo: $device_ip"

  echo "Conectando el dispositivo a través de ADB..."  
  # Conecta el dispositivo a través de ADB utilizando la dirección IP y el puerto
  adb connect "$device_ip:$port"
  # Verifica si la conexión se realizó con éxito
  connected_devices=$(adb devices)
  echo "Dispositivos conectados:"
  echo "$connected_devices"
  echo "El script se ha completado exitosamente."  
  # Liberación de recursos: desconecta el dispositivo de ADB
  # adb disconnect "$device_ip:$port"
else
  echo "No se encontraron dispositivos Android conectados."
fi
