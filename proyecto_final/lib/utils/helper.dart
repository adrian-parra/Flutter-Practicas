String obtenerUUidDeCadena(String cadena) {
    // Divide la URL en partes usando el carácter "/"
    List<String> partes = cadena.split('/');

    // Obtiene la última parte de la lista
    String ultimaParte = partes.last;

    // Divide la última parte por el carácter "."
    List<String> partesNombreArchivo = ultimaParte.split('.');

    // Obtiene la primera parte después de dividir por el punto "."
    String identificador = partesNombreArchivo.first;

    return identificador;
  }