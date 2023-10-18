import 'dart:math';
import 'package:flutter/material.dart';
import 'package:mini_proyecto_02/config.dart';
import 'package:flip_card/flip_card.dart';
import 'package:mini_proyecto_02/models/card.dart';
import 'dart:async';
import 'package:flutter_dialogs/flutter_dialogs.dart';
import '../models/enums.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GameScreen extends StatefulWidget {
  final String difficulty;

  const GameScreen({super.key, required this.difficulty});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  List<CardGame> totalCards = [
    CardGame(id: 1, imagePath: 'assets/img1.png'),
    CardGame(id: 2, imagePath: 'assets/img1.png'),
    CardGame(id: 3, imagePath: 'assets/img2.png'),
    CardGame(id: 4, imagePath: 'assets/img2.png'),
    CardGame(id: 5, imagePath: 'assets/img3.png'),
    CardGame(id: 6, imagePath: 'assets/img3.png'),
    CardGame(id: 7, imagePath: 'assets/img4.png'),
    CardGame(id: 8, imagePath: 'assets/img4.png'),
    CardGame(id: 9, imagePath: 'assets/img5.png'),
    CardGame(id: 10, imagePath: 'assets/img5.png'),
    CardGame(id: 11, imagePath: 'assets/img6.png'),
    CardGame(id: 12, imagePath: 'assets/img6.png'),

    // ... más cartas ...
  ];

  late List<CardGame> cards;

  List<GlobalKey<FlipCardState>>? cardKeys;

  bool allowFlip = true;

  bool clickAuto = false;

  int tiempo = 60; // Inicializa con el tiempo deseado en segundos
  late Timer timer;

  String? difficulty;

  final StreamController<int> _tiempoController = StreamController<int>();
  Stream<int> get tiempoStream => _tiempoController.stream;

  @override
  void initState() {
    configurarJuego();

    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConfig.colorFondo,
      appBar: AppBar(
        title: const Text(''),
        centerTitle: false,
        backgroundColor: AppConfig.colorPrincipal,
        leading: const Text(''),
        actions: [
          StreamBuilder<int>(
            stream: tiempoStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Container(
                  alignment: Alignment.center,
                  child: Text('Tiempo: ${snapshot.data} segundos'),
                );
              } else {
                return Container(
                  alignment: Alignment.center,
                  child: Text('Tiempo: 0 segundos'),
                );
              }
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              // Acción de configuración
               Navigator.pop(context);
            },
          ),
          
        ],
      ),
      body: Center(
        child: Column(
         // crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: AppConfig.gap - 5,
            ),
            // Container(
            //  width:double.infinity , // Ancho de 100 píxeles
            //  padding:EdgeInsets.only(left: AppConfig.paddingValue),
            //   // alignment: Alignment.topRight, // Alineación a la derecha
            //   child:const Text(
            //     "",
            //     style: TextStyle(
            //       fontSize: AppConfig.sizeTitulo,
            //       fontWeight: FontWeight.bold,
            //       color: AppConfig.colorPrincipal
            //     ),
            //     ),
            // ),
            Expanded(
              child: (GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 0,
                  childAspectRatio: 1,
                  mainAxisSpacing: 0,
                ),
                itemCount: cards.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {},
                    child: FlipCard(
                      key: cardKeys![index],
                      direction: FlipDirection
                          .HORIZONTAL, // Dirección de la voltereta
                      flipOnTouch: allowFlip && !cards[index].isMatched,
                      onFlip: () {
                        if (allowFlip) {
                        } else {}
                      },
                      onFlipDone: (isFront) {
                        // Código a ejecutar cuando la voltereta está completa
                        if (isFront) {
                          handleCardTap(index, false);
                        } else {
                          handleCardTap(index, true);
                        }
                      },
                      front: Card(
                          // margin: const EdgeInsets.all(8.0),
                          child: cards[index].isMatched
                              ? Container(
                                  decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                        cards[index].imagePath.toString()),
                                    fit: BoxFit.cover,
                                  ),
                                ))
                              : Container(
                                  color: AppConfig.colorDescripcion,
                                  child: const Center(
                                    child: Text(
                                      '?',
                                      style: TextStyle(
                                          color: AppConfig.colorSecundario,
                                          fontSize: AppConfig.sizeTitulo * 3),
                                    ),
                                  ),
                                )),
                      back: Card(
                          // Personaliza la apariencia de la cara trasera de la carta
                          margin: const EdgeInsets.all(8.0),
                          child: Container(
                              decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(cards[index]
                                  .imagePath
                                  .toString()), // Reemplaza con la ruta de tu imagen
                              fit: BoxFit
                                  .cover, // Puedes ajustar el ajuste de la imagen aquí
                            ),
                          ))),
                    ),
                  );
                },
              )),
            ),
          ],
        ),
      ),
    );
  }

  // ! FUNCIONES

  void iniciarJuego() {
    tiempo = 0; // Establece el tiempo inicial en segundos
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      if (tiempo >= 0 && tiempo <= 60) {
        tiempo++;
        _tiempoController.add(tiempo); // Actualiza el stream
      } else {
        // El tiempo ha terminado, realiza la lógica necesaria
        t.cancel(); // Detén el temporizador cuando se agote el tiempo
      }
    });
  }

// Función para manejar el toque en una carta
  Future<void> handleCardTap(int index, bool isFlipped) async {
    CardGame cardTap = cards[index];

    CardGame? matchedCard;

    cardTap.isFlipped = isFlipped;

    if (isFlipped == false) return; // ? DETIENE LA EJECUCIÓN DEL CÓDIGO

    int countCard = 1;
    cards.asMap().forEach((index, card) {
      if (card.isFlipped == true &&
          card.isMatched != true &&
          card.id != cardTap.id) {
        countCard++;
        matchedCard = cards[index];
      }
    });
    if (countCard == 2) {
      // ? VERIFICAR SI SE HACE MATCH
      if (cardTap.imagePath == matchedCard?.imagePath) {
        cardTap.isMatched = true;
        matchedCard?.isMatched = true;
        setState(() {}); // ? ACTUALIZA EL WIDGET

        // ? VERIFICAR SI TERMINO EL JUEGO
        if (todasLasCartasTienenMatch()) {
          if (await isRecordNew(capitalizeFirstLetter(difficulty!), tiempo)) {
            await guardarTiempoFinalizacionJuego(
                tiempo, capitalizeFirstLetter(difficulty!));
            // ignore: use_build_context_synchronously
            mostrarAlertaDeJuegoTerminado(context,
                isNewRecord: true, record: tiempo);
          } else {
            int recordActual = await obtenerTiempoFinalizacionJuego(
                capitalizeFirstLetter(difficulty!));
            // ignore: use_build_context_synchronously
            mostrarAlertaDeJuegoTerminado(context,
                isNewRecord: false, record: recordActual);
          }
          timer.cancel();
        }
      } else {
        clickAuto = true;
        int indiceCardTap = cards.indexOf(cardTap);
        int indiceMatchedCard = cards.indexOf(matchedCard!);
        if (cardKeys![indiceCardTap].currentState != null) {
          cardKeys![indiceCardTap].currentState?.toggleCard();
          cardKeys![indiceMatchedCard].currentState?.toggleCard();
        }
      }
    }
  }

  String capitalizeFirstLetter(String input) {
    if (input.isEmpty) {
      return input; // Devuelve la cadena original si está vacía
    }
    return input[0].toUpperCase() + input.substring(1);
  }

  // loal Verifica si todas las cartas del juego tienen coincidencias.

  /// Retorna `true` si todas las cartas tienen la propiedad `isMatched` establecida en `true`.
  /// Retorna `false` en caso contrario.
  bool todasLasCartasTienenMatch() {
    for (var card in cards) {
      if (!card.isMatched) {
        return false;
      }
    }
    return true;
  }

  void mostrarAlertaDeJuegoTerminado(BuildContext context,
      {required bool isNewRecord, required int record}) {
    showPlatformDialog(
      context: context,
      builder: (_) {
        return BasicDialogAlert(
          title: const Text("¡Juego Terminado!"),
          content: isNewRecord
              ? Text(
                  "Nuevo record (${record.toString()} seg.)",
                  style: const TextStyle(color: AppConfig.colorSuccess),
                )
              : Text(
                  "Record actual (${record.toString()} seg.)",
                  style: const TextStyle(color: AppConfig.colorInfo),
                ),
          actions: <Widget>[
            BasicDialogAction(
              title: const Text("Aceptar"),
              onPressed: () async {
                clearGame(); // ? RESTABLECE EL TABLERO
                Navigator.of(context).pop(); // ? Cierra la alerta
              },
            ),
          ],
        );
      },
    );
  }

  // LOAL Restablece el juego a su estado inicial al reconstruir la configuración del juego.
  void clearGame() {
    configurarJuego(); // ? RECONSTRUYE LA CONFIGURACIÓN INICIAL DEL JUEGO

    /**
     * TODO: TODO: ESTA PARTE NO SERIA NECESARIA SI LA REFERENCIA DE LOS OBJETOS totalCard y card NO SE PASARAN POR REFERENCIA 
     * */
    for (var card in cards) {
      card.isFlipped = false;
      card.isMatched = false;
    }

    setState(() {}); // ? LE INFORMA LOS CAMBIOS AL WIDGET
  }

  // LOAL Selecciona y devuelve una lista de cartas de juego en función de la dificultad especificada.

  /// [difficulty] es un valor de enumeración (Difficulty) que representa la dificultad del juego.
  /// Retorna una lista de [CardGame] que contiene las cartas seleccionadas para la dificultad dada.
  List<CardGame> selectCardsByDifficulty(Difficulty difficulty) {
    // Crea una lista vacía para almacenar las cartas seleccionadas
    List<CardGame> selectedCards = [];

    // Utiliza una declaración 'switch' para determinar la cantidad de cartas basada en la dificultad
    switch (difficulty) {
      case Difficulty.easy:
        // Para dificultad fácil, selecciona las primeras 8 cartas de 'totalCards'
        selectedCards = totalCards.take(8).toList();
        break;
      case Difficulty.medium:
        // Para dificultad media, selecciona las primeras 10 cartas de 'totalCards'
        selectedCards = totalCards.take(10).toList();
        break;
      case Difficulty.hard:
        // Para dificultad difícil, selecciona las primeras 12 cartas de 'totalCards'
        selectedCards = totalCards.take(12).toList();
        break;
    }

    // Retorna la lista de cartas seleccionadas según la dificultad
    return selectedCards;
  }

  // LOAL Configura el juego seleccionando las cartas y configurando las dificultades

  void configurarJuego() {
    // Obtiene la dificultad de los widgets
    difficulty = widget.difficulty;

    // Inicializa la variable para almacenar la dificultad seleccionada
    Difficulty selectedDifficulty;

    // Asigna la dificultad seleccionada en función del valor de 'difficulty'
    if (difficulty == 'easy') {
      selectedDifficulty = Difficulty.easy;
    } else if (difficulty == 'medium') {
      selectedDifficulty = Difficulty.medium;
    } else {
      selectedDifficulty = Difficulty.hard;
    }

    // Selecciona las cartas en función de la dificultad y las almacena en la lista 'cards'
    //cards = selectCardsByDifficulty(selectedDifficulty);
    cards = List<CardGame>.from(selectCardsByDifficulty(selectedDifficulty));

    // Baraja las cartas para que estén en un orden aleatorio
    cards.shuffle(Random());

    // Crea una lista de 'GlobalKey' para cada carta, que se utiliza para acceder a las instancias de 'FlipCardState'
    cardKeys = List.generate(
      cards.length,
      (index) => GlobalKey<FlipCardState>(),
    );

    iniciarJuego();
  }

  Future<void> guardarTiempoFinalizacionJuego(
      int tiempoFinal, String dificultad) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('tiempoFinalizacion$dificultad', tiempoFinal);
  }

  Future<bool> isRecordNew(String dificultad, int tiempoActual) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int tiempoFinal = prefs.getInt('tiempoFinalizacion$dificultad') ?? 0;

    return (tiempoActual <= tiempoFinal || tiempoFinal == 0);
  }

  Future<int> obtenerTiempoFinalizacionJuego(String dificultad) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int tiempoFinal = prefs.getInt('tiempoFinalizacion$dificultad') ??
        0; // Valor predeterminado si no se encuentra
    return tiempoFinal;
  }
}
