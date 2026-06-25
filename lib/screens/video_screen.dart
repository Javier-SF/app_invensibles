import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoScreen extends StatefulWidget {
  final int currentTab;
  const VideoScreen({super.key, required this.currentTab});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.asset('assets/video/videoplayback.mp4')
      ..initialize()
          .then((_) {
            if (mounted) {
              setState(() {
                _isInitialized = true;
                // Solo reproducimos al iniciar si estamos en la pestaña 0
                if (widget.currentTab == 0) {
                  _controller.play();
                }
                _controller.setLooping(true);
              });
            }
          })
          .catchError((error) {
            debugPrint("Error al inicializar el video: $error");
          });
  }

  // --- AQUÍ ESTÁ EL TRUCO CLAVE ---
  @override
  void didUpdateWidget(covariant VideoScreen oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Si el video no se ha inicializado todavía, no hacemos nada para evitar errores
    if (!_isInitialized) return;

    if (widget.currentTab != 0) {
      // Si el usuario cambió a CUALQUIER otra pestaña, pausamos el video
      if (_controller.value.isPlaying) {
        _controller.pause();
      }
    } else {
      // Si el usuario regresó a la pestaña 0 (Historia/Presentación), lo reanudamos
      if (!_controller.value.isPlaying) {
        _controller.play();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return FittedBox(
        fit: BoxFit.fitWidth,
        child: Container(
          width: 700,
          height: 500,
          color: Colors.grey[50],
          child: Center(
            child: Image.asset(
              'assets/images/image-Photoroom.png',
              height: 50,
              width: 100,
            ),
          ),
        ),
      );
    }

    return FittedBox(
      fit: BoxFit.fitWidth, // Cubre toda la pantalla recortando lo necesario
      child: SizedBox(width: 900, height: 800, child: VideoPlayer(_controller)),
    );
  }
}
