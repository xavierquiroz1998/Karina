// ignore_for_file: use_build_context_synchronously
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tesis_karina/provider/cultivo_task_provider.dart';
import 'package:tesis_karina/provider/seguimiento3_provider.dart';
import 'package:tesis_karina/style/colors/custom_colors.dart';

// A widget that displays the picture taken by the user.
class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;
  final String nameImag;

  const DisplayPictureScreen(
      {super.key, required this.imagePath, required this.nameImag});

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final provider = Provider.of<Seguimiento3Provider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Foto'),
        backgroundColor: CustomColors.customDefaut,
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 15, bottom: 10),
            // ignore: prefer_const_constructors
            child: Text('IMAGEN TOMADA',
                style: const TextStyle(color: Colors.black, fontSize: 14)),
          ),
          Expanded(child: Image.file(File(imagePath))),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                  onPressed: () async {
                    File file = File(imagePath);
                    Uint8List imgbytes = file.readAsBytesSync();
                    provider.imgBs4 = base64Encode(imgbytes);
                    await Navigator.of(context)
                        .pushReplacementNamed("/dashboard/controlSeguimiento3");
                  },
                  icon: const Icon(Icons.camera_alt),
                  label: const Text('Guardar')),
              const SizedBox(width: 8),
              ElevatedButton.icon(
                  onPressed: () async => Navigator.pushReplacementNamed(
                      context, '/dashboard/controlSeguimiento3'),
                  icon: const Icon(Icons.cancel),
                  label: const Text('Cancelar'))
            ],
          )
        ],
      ),
    );
  }
}
