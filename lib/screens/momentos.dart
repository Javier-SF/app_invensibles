import 'dart:ui';
import 'package:flutter/material.dart';

class InvincibleMomentsPage extends StatelessWidget {
  const InvincibleMomentsPage({super.key});

  // Lista de los mejores momentos con los datos de tus cortos
  final List<Map<String, String>> _seriesShorts = const [
    {
      'title': 'Omni-Man vs. Los Guardianes del Globo',
      'duration': '3:45',
      'season': 'Temporada 1',
      'thumbnail': 'assets/img_juegos/imag1.jpg', // Verifica si es imag1 o img1
      'description':
          'El impactante e inesperado enfrentamiento que lo cambió todo.',
    },
    {
      'title': 'Mark descubre la verdad ("Piensa, Mark")',
      'duration': '5:12',
      'season': 'Temporada 1',
      'thumbnail': 'assets/img_juegos/img2.jpg',
      'description':
          'La devastadora batalla final entre padre e hijo en Chicago.',
    },
    {
      'title': 'La llegada de Angstrom Levy',
      'duration': '4:20',
      'season': 'Temporada 2',
      'thumbnail': 'assets/img_juegos/img3.jpg',
      'description': 'El inicio de la amenaza multiversal que acecha a Mark.',
    },
    {
      'title': 'Invencible y Atom Eve vs. Doc Seismic',
      'duration': '2:30',
      'season': 'Temporada 1',
      'thumbnail': 'assets/img_juegos/img4.jpg',
      'description':
          'Una gran demostración de trabajo en equipo y sincronización.',
    },
    {
      'title': 'Batalla en el Planeta Thraxa',
      'duration': '6:05',
      'season': 'Temporada 2',
      'thumbnail': 'assets/img_juegos/img5.jpg',
      'description':
          'El reencuentro con Omni-Man y la brutal defensa contra los Viltrumitas.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SafeArea(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 10.0,
            ),
            itemCount: _seriesShorts.length,
            itemBuilder: (context, index) {
              final short = _seriesShorts[index];

              return Container(
                margin: const EdgeInsets.only(bottom: 20.0),
                decoration: BoxDecoration(
                  color: const Color(0xFF1F222A).withOpacity(0.9),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Colors.yellowAccent.withOpacity(
                      0.2,
                    ), // Estilo cómic sutil
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // --- BLOQUE CORREGIDO DE LA MINIATURA ---
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          // Caja contenedora que obliga al ancho completo de la tarjeta
                          SizedBox(
                            width: double.infinity,
                            height: 180,
                            child: Image.asset(
                              short['thumbnail']!,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                // Contenedor alternativo si la imagen falla (evita que se colapse)
                                return Container(
                                  width: double.infinity,
                                  height: 180,
                                  color: Colors.white.withOpacity(0.05),
                                  child: const Icon(
                                    Icons.video_library_rounded,
                                    color: Colors.white24,
                                    size: 45,
                                  ),
                                );
                              },
                            ),
                          ),
                          // Sombreado interno inferior para dar contraste
                          Positioned.fill(
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.transparent,
                                    Colors.black.withOpacity(0.7),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          // Botón central de reproducción (Play)
                          CircleAvatar(
                            radius: 28,
                            backgroundColor: Colors.redAccent.withOpacity(0.9),
                            child: const Icon(
                              Icons.play_arrow_rounded,
                              color: Colors.white,
                              size: 36,
                            ),
                          ),
                          // Duración del corto (Abajo a la derecha)
                          Positioned(
                            bottom: 10,
                            right: 12,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.85),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                short['duration']!,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          // Etiqueta de la temporada (Arriba a la izquierda)
                          Positioned(
                            top: 10,
                            left: 12,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.yellowAccent.shade700,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                short['season']!.toUpperCase(),
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      // --- FIN DEL BLOQUE DE MINIATURA ---

                      // Sección inferior: Textos descriptivos
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              short['title']!,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              short['description']!,
                              style: TextStyle(
                                color: Colors.grey.shade400,
                                fontSize: 14,
                                height: 1.3,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
