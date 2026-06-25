import 'package:app_invensibles/class/character.dart';
import 'package:app_invensibles/const/lorem.dart';
import 'package:app_invensibles/screens/descricion_pj_screen.dart';
import 'package:flutter/material.dart';

class CharacterCarouselScreen extends StatefulWidget {
  const CharacterCarouselScreen({Key? key}) : super(key: key);

  @override
  State<CharacterCarouselScreen> createState() =>
      _CharacterCarouselScreenState();
}

class _CharacterCarouselScreenState extends State<CharacterCarouselScreen> {
  late PageController _pageController;
  int _currentPage = 0;

  // Lista simulada de personajes (puedes cambiarlo por tu API o base de datos)
  final List<Character> characters = [
    Character(
      name: "Markus Sebastian ( Mark )",
      imagePath: "assets/images/mark.jpg",
      description: inivincible,
    ),
    Character(
      name: "Omni-Man",
      imagePath: "assets/images/Omniman_Invinsible.jpg",
      description: oniman,
    ),
    Character(
      name: "Conquest",
      imagePath: "assets/images/Conquest.jpg",
      description: conquet,
    ),
  ];

  @override
  void initState() {
    super.initState();
    // viewportFraction menor a 1.0 permite ver las tarjetas de los lados
    _pageController = PageController(initialPage: 0, viewportFraction: 0.75);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 40),
            // Aquí puedes meter tus filtros de arriba (ej: Categorías, Clanes, etc.)
            Text(
              characters[_currentPage].name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            // Text(
            //   characters[_currentPage].,
            //   style: const TextStyle(color: Colors.grey, fontSize: 16),
            // ),
            const SizedBox(height: 30),

            // El Carrusel de Tarjetas
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: characters.length,
                onPageChanged: (int index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  // Efecto de escala animada para la tarjeta activa
                  return AnimatedBuilder(
                    animation: _pageController,
                    builder: (context, child) {
                      double value = 1.0;
                      if (_pageController.position.haveDimensions) {
                        value = _pageController.page! - index;
                        value = (1 - (value.abs() * 0.15)).clamp(0.0, 1.0);
                      } else {
                        value = index == 0 ? 1.0 : 0.85;
                      }
                      return Transform.scale(scale: value, child: child);
                    },
                    child: GestureDetector(
                      onTap: () {
                        // Navegación a la pantalla de resumen al tocar el personaje
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CharacterDetailScreen(
                              character: characters[index],
                            ),
                          ),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 20,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(28),
                          border: Border.all(color: Colors.white24, width: 2),
                          image: DecorationImage(
                            image: AssetImage(characters[index].imagePath),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
