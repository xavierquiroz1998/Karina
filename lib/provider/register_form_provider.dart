import 'package:flutter/material.dart';

class RegisterFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';

  validateForm() {
    if (formKey.currentState!.validate()) {
      print('$email === $password');
      return true;
    } else {
      return false;
    }
  }
}
