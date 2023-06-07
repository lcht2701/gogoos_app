import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obsecureText;
  final Color color;
  final TextInputType inputType;
  final Icon icon;

  const MyTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.obsecureText,
      required this.color,
      required this.inputType,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obsecureText,
      cursorColor: color,
      keyboardType: inputType,
      style: TextStyle(color: color, fontSize: 14),
      decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.white, fontSize: 14),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          prefixIcon: icon,
          prefixIconColor: Colors.white),
    );
  }
}
