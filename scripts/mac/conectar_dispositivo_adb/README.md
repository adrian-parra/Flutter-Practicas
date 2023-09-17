# Script de Conexión ADB (Solo para macOS)

Este script de Bash está diseñado para automatizar la configuración y conexión de dispositivos Android a través de ADB (Android Debug Bridge) en modo TCP/IP. Puede ser útil cuando necesitas conectar tu dispositivo Android de forma inalámbrica a través de ADB.

## Requisitos

Antes de ejecutar este script, asegúrate de que se cumplan los siguientes requisitos:

1. [ADB (Android Debug Bridge)](https://developer.android.com/studio/command-line/adb) debe estar instalado en tu sistema.

## Uso

Ejecuta el script proporcionando las siguientes opciones:

- `-h` o `--help`: Muestra información sobre cómo usar el script y las opciones disponibles.

- `-p` o `--port`: Especifica el puerto TCP/IP para la conexión (predeterminado: 5555).

Ejemplos:

```bash
./conectar_dispositivo_via_ip.sh -h  # Muestra la ayuda
./conectar_dispositivo_via_ip.sh -p 8888  # Configura el puerto TCP/IP en 8888
./conectar_dispositivo.sh  # Configura el puerto TCP/IP en 5555
```

## Funcionamiento

El script sigue los siguientes pasos:

1. Verificación de ADB: El script verifica si ADB está instalado en tu sistema. Si no lo está, mostrará un mensaje de error y te pedirá que instales ADB.

2. Configuración TCP/IP: Luego, el script configurará el dispositivo Android para la conexión en modo TCP/IP en el puerto especificado (predeterminado: 5555).

3. Espera: Espera unos segundos para que el dispositivo esté listo.

4. Obtención de la dirección IP: Obtiene la dirección IP del dispositivo Android.

5. Conexión ADB: Conecta el dispositivo a través de ADB utilizando la dirección IP y el puerto.

6. Verificación: Verifica si la conexión se realizó con éxito y muestra la lista de dispositivos conectados.

7. Liberación de recursos: Al finalizar, desconecta el dispositivo de ADB.

## Advertencia

Este script supone que estás utilizando ADB para depuración de dispositivos Android. Asegúrate de que tu dispositivo esté configurado para la depuración USB y que la conexión USB esté habilitada antes de ejecutar el script.