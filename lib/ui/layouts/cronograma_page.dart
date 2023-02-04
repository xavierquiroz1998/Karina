import 'package:flutter/material.dart';

class CronogramaPage extends StatefulWidget {
  CronogramaPage({Key? key}) : super(key: key);

  @override
  State<CronogramaPage> createState() => _CronogramaPageState();
}

class _CronogramaPageState extends State<CronogramaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cronograma de Actv.')),
      body: Container(),
    );
  }
}
