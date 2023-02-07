import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tesis_karina/style/custom/custom_input.dart';

class InputForm extends StatelessWidget {
  final Function? validator;
  final Function? onEditingComplete;
  final Function? onChanged;
  final TextEditingController controller;
  final int maxLines;
  final bool enable;
  final String regx;
  final int length;
  final String hint;
  final IconData icon;
  final bool oscureText;
  final bool mayuscula;
  final FocusNode? node;
  final TextInputType textInputType;

  const InputForm(
      {Key? key,
      required this.hint,
      required this.icon,
      required this.controller,
      this.regx = "",
      required this.length,
      this.validator,
      this.onEditingComplete,
      this.node,
      this.mayuscula = false,
      this.oscureText = false,
      this.onChanged,
      this.maxLines = 1,
      this.textInputType = TextInputType.text,
      this.enable = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) => validator!(value),
      enabled: enable,
      controller: controller,
      maxLines: maxLines,
      focusNode: node,
      obscureText: oscureText,
      inputFormatters: [
        LengthLimitingTextInputFormatter(length),
        if (mayuscula) UpperCaseTextFormatter()
      ],
      keyboardType: textInputType,
      style: const TextStyle(fontSize: 14),
      decoration: CustomInputs.boxInputDecoration2(
        hint: hint,
        icon: icon,
      ),
    );
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
