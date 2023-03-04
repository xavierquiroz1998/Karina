import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:tesis_karina/style/colors/custom_colors.dart';
import 'package:tesis_karina/ui/layouts/diasplay_screen2.dart';

// A screen that allows users to take a picture using a given camera.
class TakePictureScreen3 extends StatefulWidget {
  const TakePictureScreen3({
    super.key,
    required this.camera,
  });

  final CameraDescription camera;

  @override
  TakePictureScreen3State createState() => TakePictureScreen3State();
}

class TakePictureScreen3State extends State<TakePictureScreen3> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium,
    );

    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Camara'),
        backgroundColor: CustomColors.customDefaut,
      ),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(_controller);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {
            await _initializeControllerFuture;
            final image = await _controller.takePicture();

            if (!mounted) return;
            await Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => DisplayPictureScreen2(
                  imagePath: image.path,
                  nameImag: image.name,
                ),
              ),
            );
          } catch (e) {
            print(e);
          }
        },
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}
