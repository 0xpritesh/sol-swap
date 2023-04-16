import 'package:flutter/material.dart';

Widget styledTextFeild(TextEditingController controller, String hint,
    TextInputType keyboard, bool readonly, IconData icon) {
  return TextFormField(
    keyboardType: keyboard,
    readOnly: readonly,
    controller: controller,
    decoration: InputDecoration(
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.black38),
        borderRadius: BorderRadius.circular(5.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.blue),
        borderRadius: BorderRadius.circular(5.5),
      ),
      prefixIcon: Icon(icon),
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.black38),
      filled: true,
      fillColor: Colors.white,
    ),
  );
}
