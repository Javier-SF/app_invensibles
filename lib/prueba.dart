import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class SnakeGamePage extends StatefulWidget {
  const SnakeGamePage({super.key});

  @override
  State<SnakeGamePage> createState() => _SnakeGamePageState();
}

class _SnakeGamePageState extends State<SnakeGamePage> {
  // Configuración del tablero (matriz de 20x20)
  final int squaresPerRow = 20;
  final int totalSquares = 400;

  // Estado del juego
  List<int> snakePosition = [45, 65, 85]; // Posición inicial del cuerpo
  int foodPosition = 300; // Posición inicial de la comida
  String direction = 'down'; // Dirección inicial
  bool isPlaying = false;
  Timer? gameTimer;
  int score = 0;

  // Iniciar o reiniciar el juego
  void startGame() {
    setState(() {
      snakePosition = [45, 65, 85];
      foodPosition = Random().nextInt(totalSquares);
      direction = 'down';
      isPlaying = true;
      score = 0;
    });

    // El temporizador controla la velocidad del juego (cada 200ms se mueve)
    gameTimer?.cancel();
    gameTimer = Timer.periodic(const Duration(milliseconds: 200), (timer) {
      updateSnake();
    });
  }

  void updateSnake() {
    setState(() {
      // Calcular la nueva cabeza dependiendo de la dirección
      int nextHead = snakePosition.last;
      switch (direction) {
        case 'down':
          nextHead += squaresPerRow;
          break;
        case 'up':
          nextHead -= squaresPerRow;
          break;
        case 'left':
          nextHead -= 1;
          break;
        case 'right':
          nextHead += 1;
          break;
      }

      // 1. Condición de choque: Bordes o chocarse consigo misma
      if (nextHead < 0 ||
          nextHead >= totalSquares ||
          (direction == 'left' && (nextHead + 1) % squaresPerRow == 0) ||
          (direction == 'right' && nextHead % squaresPerRow == 0) ||
          snakePosition.contains(nextHead)) {
        gameTimer?.cancel();
        isPlaying = false;
        _showGameOverDialog();
        return;
      }

      // Añadir nueva cabeza
      snakePosition.add(nextHead);

      // 2. Condición: ¿Come la comida?
      if (nextHead == foodPosition) {
        score += 10;
        // Generar nueva comida en un lugar vacío
        do {
          foodPosition = Random().nextInt(totalSquares);
        } while (snakePosition.contains(foodPosition));
      } else {
        // Si no come, remueve la cola para mantener el tamaño en movimiento
        snakePosition.removeAt(0);
      }
    });
  }

  void _showGameOverDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('¡Game Over!'),
        content: Text('Puntuación final: $score'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              startGame();
            },
            child: const Text('Jugar de nuevo'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    gameTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
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
          // Marcador Superior
          Expanded(
            child: Container(
              alignment: Alignment.center,
              child: Text(
                'Puntos: $score',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          // Tablero del juego (Cuadrícula)
          AspectRatio(
            aspectRatio: 1,
            child: Container(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white24),
                color: const Color(0xFF111115),
              ),
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: totalSquares,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: squaresPerRow,
                ),
                itemBuilder: (context, index) {
                  if (snakePosition.contains(index)) {
                    // Si el índice es parte de la serpiente (Cabeza vs Cuerpo)
                    bool isHead = index == snakePosition.last;
                    return Container(
                      padding: const EdgeInsets.all(2),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: Container(
                          color: isHead ? Colors.greenAccent : Colors.green,
                        ),
                      ),
                    );
                  } else if (index == foodPosition) {
                    // Si el índice es comida
                    return Container(
                      padding: const EdgeInsets.all(2),
                      child: const CircleAvatar(
                        backgroundColor: Colors.redAccent,
                      ),
                    );
                  } else {
                    // Espacio vacío del mapa
                    return const SizedBox();
                  }
                },
              ),
            ),
          ),

          // Controles inferiores d-pad (Botones de dirección)
          Expanded(
            flex: 2,
            child: isPlaying
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        iconSize: 50,
                        icon: const Icon(
                          Icons.keyboard_arrow_up,
                          color: Colors.white,
                        ),
                        onPressed: () =>
                            direction != 'down' ? direction = 'up' : null,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            iconSize: 50,
                            icon: const Icon(
                              Icons.keyboard_arrow_left,
                              color: Colors.white,
                            ),
                            onPressed: () => direction != 'right'
                                ? direction = 'left'
                                : null,
                          ),
                          const SizedBox(width: 50),
                          IconButton(
                            iconSize: 50,
                            icon: const Icon(
                              Icons.keyboard_arrow_right,
                              color: Colors.white,
                            ),
                            onPressed: () => direction != 'left'
                                ? direction = 'right'
                                : null,
                          ),
                        ],
                      ),
                      IconButton(
                        iconSize: 50,
                        icon: const Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.white,
                        ),
                        onPressed: () =>
                            direction != 'up' ? direction = 'down' : null,
                      ),
                    ],
                  )
                : Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 15,
                        ),
                      ),
                      onPressed: startGame,
                      child: const Text(
                        '¡EMPEZAR!',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
