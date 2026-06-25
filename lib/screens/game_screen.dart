import 'dart:async';
import 'dart:math';
import 'package:app_invensibles/class/juego.dart';
import 'package:flutter/material.dart';

class MemoryGamePage extends StatefulWidget {
  const MemoryGamePage({super.key});

  @override
  State<MemoryGamePage> createState() => _MemoryGamePageState();
}

class _MemoryGamePageState extends State<MemoryGamePage> {
  // 1. CAMBIO: Lista ampliada a 12 imágenes únicas para un total de 24 cuadros (4x6)
  final List<String> _cardImages = [
    'assets/imgjuegos/imag1.jpg',
    'assets/imgjuegos/img2.jpg',
    'assets/imgjuegos/img3.jpg',
    'assets/imgjuegos/img4.jpg',
    'assets/imgjuegos/img5.jpg',
    'assets/imgjuegos/img6.jpg',
    'assets/imgjuegos/img7.jpg',
  ];

  List<CardModel> _cards = [];
  int _score = 0;
  bool _isPlaying = false;
  bool _isPaused = false;

  int? _firstSelectedIndex;
  bool _isBusy = false;

  Timer? _gameTimer;
  int _secondsPassed = 0;
  int _bestRecord = 999;

  @override
  void initState() {
    super.initState();
    _setupGame();
  }

  // Al reiniciar o iniciar por primera vez, el juego se limpia pero NO corre el temporizador
  void _setupGame() {
    setState(() {
      _score = 0;
      _secondsPassed = 0;
      _firstSelectedIndex = null;
      _isBusy = false;
      _isPaused = false;
      _isPlaying =
          false; // El juego se queda en espera de ser iniciado oficialmente

      _gameTimer?.cancel(); // Frenamos cualquier timer previo inmediatamente

      List<String> gameImages = [..._cardImages, ..._cardImages];
      gameImages.shuffle();

      _cards = gameImages
          .map((imagePath) => CardModel(icon: imagePath))
          .toList();
    });
  }

  void _startTimer() {
    _gameTimer?.cancel();
    _gameTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_isPlaying && !_isPaused) {
        setState(() {
          _secondsPassed++;
        });
      }
    });
  }

  // 2. CAMBIO: Esta función se encarga estrictamente de encender las banderas de juego
  void _startGame() {
    setState(() {
      _isPlaying = true;
    });
    _startTimer();
  }

  void _togglePause() {
    if (!_isPlaying) return;
    setState(() {
      _isPaused = !_isPaused;
    });
  }

  void _onCardTap(int index) {
    // 3. CAMBIO: Si _isPlaying es false, el tap se bloquea por completo
    if (!_isPlaying ||
        _isPaused ||
        _cards[index].isFaceUp ||
        _cards[index].isMatched ||
        _isBusy) {
      return;
    }

    setState(() {
      _cards[index].isFaceUp = true;
    });

    if (_firstSelectedIndex == null) {
      _firstSelectedIndex = index;
    } else {
      _isBusy = true;
      int prevIndex = _firstSelectedIndex!;

      if (_cards[index].icon == _cards[prevIndex].icon) {
        setState(() {
          _cards[index].isMatched = true;
          _cards[prevIndex].isMatched = true;
          _score += 10;
          _firstSelectedIndex = null;
          _isBusy = false;
        });

        if (_cards.every((card) => card.isMatched)) {
          _gameTimer?.cancel();
          _isPlaying = false;
          _checkAndUpdateRecord();
          _showWinDialog();
        }
      } else {
        Timer(const Duration(milliseconds: 500), () {
          setState(() {
            _cards[index].isFaceUp = false;
            _cards[prevIndex].isFaceUp = false;
            _firstSelectedIndex = null;
            _isBusy = false;
          });
        });
      }
    }
  }

  void _checkAndUpdateRecord() {
    if (_secondsPassed < _bestRecord) {
      setState(() {
        _bestRecord = _secondsPassed;
      });
    }
  }

  void _showWinDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1F222A),
        title: const Text(
          '¡Victoria!',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        content: Text(
          'Tiempo de esta partida: $_secondsPassed segundos.\nTu mejor récord: ${_bestRecord == 999 ? "Ninguno" : "$_bestRecord s"}\nPuntuación final: $_score',
          style: const TextStyle(color: Colors.grey, fontSize: 16),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _setupGame(); // Al ganar te limpia el tablero y te deja listo para darle empezar
            },
            child: const Text(
              'Ir al Menú',
              style: TextStyle(color: Colors.greenAccent),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _gameTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Opacity(
            opacity: 0.25,
            child: Image.asset(
              'assets/images/3122a6e4-769a-46e3-9512-ce4cc5f64dce.jpg',
              fit: BoxFit.cover,
            ),
          ),
        ),
        SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  '🏆 Mejor Récord: ${_bestRecord == 999 ? "-" : "$_bestRecord s"}',
                  style: TextStyle(
                    color: Colors.amberAccent.shade200,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 10.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Puntos: $_score',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (_isPlaying)
                      IconButton(
                        icon: Icon(
                          _isPaused ? Icons.play_arrow : Icons.pause,
                          color: Colors.orangeAccent,
                        ),
                        iconSize: 32,
                        onPressed: _togglePause,
                      ),
                    Row(
                      children: [
                        const Icon(Icons.timer, color: Colors.redAccent),
                        const SizedBox(width: 5),
                        Text(
                          '${_secondsPassed}s',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: _isPaused
                      ? const Center(
                          child: Text(
                            'JUEGO EN PAUSA',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      : GridView.builder(
                          itemCount: _cards.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4, // 4 columnas fijas
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                              ),
                          itemBuilder: (context, index) {
                            final card = _cards[index];
                            bool showContent = card.isFaceUp || card.isMatched;

                            return GestureDetector(
                              onTap: () => _onCardTap(index),
                              child: TweenAnimationBuilder<double>(
                                tween: Tween<double>(
                                  begin: 0,
                                  end: showContent ? pi : 0,
                                ),
                                duration: const Duration(milliseconds: 250),
                                builder: (context, val, child) {
                                  bool isBack = val < pi / 2;

                                  return Transform(
                                    transform: Matrix4.identity()
                                      ..setEntry(3, 2, 0.002)
                                      ..rotateY(val),
                                    alignment: Alignment.center,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: isBack
                                            ? Colors.green.withOpacity(0.8)
                                            : const Color(
                                                0xFF1F222A,
                                              ).withOpacity(0.9),
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: card.isMatched
                                              ? Colors.greenAccent
                                              : Colors.white24,
                                          width: card.isMatched ? 2 : 1,
                                        ),
                                      ),
                                      child: Transform(
                                        alignment: Alignment.center,
                                        transform: Matrix4.identity()
                                          ..rotateY(isBack ? 0 : pi),
                                        child: isBack
                                            ? const Center(
                                                child: Icon(
                                                  Icons.help_outline,
                                                  size:
                                                      30, // Tamaño sutilmente reducido para la densidad de cartas
                                                  color: Colors.white54,
                                                ),
                                              )
                                            : Center(
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                    6.0,
                                                  ),
                                                  child: Image.asset(
                                                    card.icon,
                                                    fit: BoxFit.contain,
                                                  ),
                                                ),
                                              ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                ),
              ),
              // SECCIÓN DEL BOTÓN DINÁMICO
              Padding(
                padding: const EdgeInsets.only(bottom: 25.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isPlaying
                        ? Colors.redAccent
                        : Colors.green,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 50,
                      vertical: 15,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  // Si ya está jugando ejecuta la limpieza estática, si no, inicia la partida
                  onPressed: _isPlaying ? _setupGame : _startGame,
                  child: Text(
                    _isPlaying ? 'REINICIAR' : '¡EMPEZAR!',
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
