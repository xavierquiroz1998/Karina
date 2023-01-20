import 'package:flutter/material.dart';
import 'package:tesis_karina/style/custom/custom_labels.dart';

class ExpirePage extends StatelessWidget {
  const ExpirePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipOval(
                child: Image.asset(
                  'assets/no-acceso.png',
                  width: 300,
                  height: 300,
                  fit: BoxFit.contain,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Error!',
                  style: CustomLabels.h8,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
