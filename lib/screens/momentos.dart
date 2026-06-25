import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class InvincibleMomentsPage extends StatefulWidget {
  const InvincibleMomentsPage({super.key});

  @override
  State<InvincibleMomentsPage> createState() => _InvincibleMomentsPageState();
}

class _InvincibleMomentsPageState extends State<InvincibleMomentsPage> {
  // Datos de los videos (Inmutables)
  final List<Map<String, String>> _seriesShorts = const [
    {
      'title': 'Omni-Man vs. Los Guardianes del Globo',
      'season': 'Temporada 1',
      'youtubeId': 'DIn2PDXCnmA',
      'description':
          'El impactante e inesperado enfrentamiento que lo cambió todo.',
    },
    {
      'title': 'Mark descubre la verdad ("Piensa, Mark")',
      'season': 'Temporada 1',
      'youtubeId': 'LfAfLc58feA',
      'description':
          'La devastadora batalla final entre padre e hijo en Chicago.',
    },
    {
      'title': 'Omni-Man y Mark vs. Los Vilmitas',
      'season': 'Temporada 2',
      'youtubeId': '0uU8GjxH3M0',
      'description':
          'Padre e hijo luchan codo a codo por primera vez contra los despiadados guerreros enviados por el Imperio Viltrumita.',
    },
  ];
  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: YoutubePlayerController(initialVideoId: ''),
      ),
      builder: (context, player) {
        return Scaffold(
          backgroundColor: Colors.black,
          body: SafeArea(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 10.0,
              ),
              itemCount: _seriesShorts.length,
              itemBuilder: (context, index) {
                final short = _seriesShorts[index];

                // CAMBIO AQUÍ: Usamos ValueKey para mantener un control estricto del ciclo de vida
                return VideoCardItem(
                  key: ValueKey(short['youtubeId']!),
                  title: short['title']!,
                  season: short['season']!,
                  youtubeId: short['youtubeId']!,
                  description: short['description']!,
                );
              },
            ),
          ),
        );
      },
    );
  }
}

class VideoCardItem extends StatefulWidget {
  final String title;
  final String season;
  final String youtubeId;
  final String description;

  const VideoCardItem({
    super.key,
    required this.title,
    required this.season,
    required this.youtubeId,
    required this.description,
  });

  @override
  State<VideoCardItem> createState() => _VideoCardItemState();
}

class _VideoCardItemState extends State<VideoCardItem> {
  late YoutubePlayerController _controller;
  bool _hasVideoError = false;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.youtubeId,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
      ),
    )..addListener(_videoListener);
  }

  void _videoListener() {
    if (_controller.value.hasError) {
      if (mounted && !_hasVideoError) {
        setState(() {
          _hasVideoError = true;
        });
      }
    }
  }

  @override
  void dispose() {
    // CAMBIO AQUÍ: Removemos el listener primero y usamos una pequeña pausa
    // antes de destruir el controlador para que la animación de la barra no choque
    _controller.removeListener(_videoListener);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      decoration: BoxDecoration(
        color: const Color(0xFF1F222A).withOpacity(0.9),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.yellowAccent.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 200,
                  child: _hasVideoError
                      ? Container(
                          color: Colors.white.withOpacity(0.05),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.error_outline_rounded,
                                color: Colors.redAccent,
                                size: 45,
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Este video no está disponible',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        )
                      : YoutubePlayer(
                          controller: _controller,
                          showVideoProgressIndicator: true,
                          progressIndicatorColor: Colors.redAccent,
                          progressColors: const ProgressBarColors(
                            playedColor: Colors.redAccent,
                            handleColor: Colors.redAccent,
                          ),
                        ),
                ),
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
                      widget.season.toUpperCase(),
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
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    widget.description,
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
  }
}
