import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({super.key});

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
                _controller.play();
                _controller.setLooping(true);
              });
            }
          })
          .catchError((error) {
            debugPrint("Error al inicializar el video: $error");
          });
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
            // child: Column(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Icon(Icons.error_outline_rounded, color: Colors.red, size: 80),
            //     Text(
            //       'Error en reproducirse el viedeo favor de contactar al desarrllador',
            //       style: TextStyle(fontSize: 20),
            //     ),
            //   ],
            // ),
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
