import 'package:app_invensibles/screens/video_screen.dart';
import 'package:flutter/material.dart';
import 'package:app_invensibles/const/lorem.dart';

class Presentacion extends StatefulWidget {
  final int currentTab;
  const Presentacion({super.key, required this.currentTab});

  @override
  State<Presentacion> createState() => _PresentacionState();
}

class _PresentacionState extends State<Presentacion> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final videoHeight = screenSize.height * 0.50; // Altura asignada al video
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: videoHeight,
            child: Stack(
              children: [
                // El Video nítido (ocupa el área superior)
                Positioned.fill(
                  bottom: 60,
                  child: VideoScreen(
                    currentTab: widget.currentTab,
                  ), // <-- Pasamos el índice actual aquí
                ),

                // Gradiente para fusionar la parte inferior del video con el fondo
                Positioned.fill(
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.transparent,
                          Colors.black54, // Suaviza la transición
                          Colors
                              .black, // Hace match con el inicio del fondo opaco
                        ],
                        stops: [0.0, 0.5, 0.85, 1.0],
                      ),
                    ),
                  ),
                ),

                Positioned(
                  bottom: 16,
                  left: 20,
                  right: 20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/image-Photoroom.png',
                        height: 100,
                        width: 250,
                      ),

                      const SizedBox(height: 12),
                      Row(
                        children: [
                          _buildBadge(
                            'IMDb',
                            const Color(0xFFE0CC19),
                            Colors.white,
                          ),
                          const SizedBox(width: 8),
                          _buildBadge(
                            '8.7',
                            const Color(0xFF2E7D32),
                            Colors.white,
                          ),
                          const SizedBox(width: 8),
                          _buildBadge(
                            'prime video',
                            const Color(0xFF1976D2),
                            Colors.white,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Metadatos y Sinopsis
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 12.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Serie de TV • 2021 • Sci-Fi • USA • 1 Seasons • +18',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  resumen1,
                  style: TextStyle(
                    color: Colors.white.withOpacity(
                      0.9,
                    ), // Más brillante para leer sobre la imagen de fondo
                    fontSize: 15,
                    height: 1.4,
                  ),
                ),
                SizedBox(height: 15),
                Text(
                  dequetrata,
                  style: TextStyle(
                    color: Colors.white.withOpacity(
                      0.9,
                    ), // Más brillante para leer sobre la imagen de fondo
                    fontSize: 15,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildBadge(String text, Color bgColor, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }
}
