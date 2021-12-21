import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final bool obscureText;
  final String labelText;

  final FormFieldValidator<String>? validator;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final FormFieldSetter<String>? onSaved;

  TextFieldWidget({
    required this.obscureText,

    required this.labelText, this.validator, this.controller, this.keyboardType, this.onSaved,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onSaved: onSaved,

      obscureText: obscureText,
      keyboardType: keyboardType,

      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: labelText,

      ),
      validator: validator,

    );
  }
}
