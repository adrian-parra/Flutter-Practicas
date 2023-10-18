class CardGame {
  final int id;        // Identificador único de la carta
  final String imagePath;  // Ruta de la imagen asociada a la carta
  bool isFlipped;      // Indica si la carta está boca arriba
  bool isMatched;      // Indica si la carta ha sido emparejada

  CardGame({
    required this.id,
    required this.imagePath,
    this.isFlipped = false,
    this.isMatched = false,
  });
}
