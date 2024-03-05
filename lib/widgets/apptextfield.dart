import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final String text;

  const AppTextField({Key? key, required this.controller, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        labelText: text,
        labelStyle: const TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 22.0,
          color: Color(0xFF2849E5),
        ),
      ),
      style: const TextStyle(
        color: Colors.black,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
      keyboardType: TextInputType.number,
    );
  }
}
