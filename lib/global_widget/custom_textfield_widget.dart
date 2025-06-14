import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final bool obscureText;

  const CustomTextField({
    super.key,
    required this.label,
    required this.controller,
    this.obscureText = false, required bool isPassword,
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    final isPasswordField = widget.label.toLowerCase() == 'password';

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.25),
            offset: Offset(2, 2),
            blurRadius: 2,
            spreadRadius: 0,
          ),
        ],
      ),
      child: TextField(
        controller: widget.controller,
        obscureText: isPasswordField ? _obscurePassword : widget.obscureText,
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          hintText: widget.label,
          hintStyle: const TextStyle(color: Colors.grey),
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(8),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black, width: 2),
            borderRadius: BorderRadius.circular(8),
          ),
          contentPadding: const EdgeInsets.symmetric(
              horizontal: 16, vertical: 14),
          filled: true,
          fillColor: Colors.white,
          suffixIcon: isPasswordField
              ? IconButton(
            icon: Icon(
              _obscurePassword ? Icons.visibility_off : Icons.visibility,
              color: Colors.black,
            ),
            onPressed: () {
              setState(() {
                _obscurePassword = !_obscurePassword;
              });
            },
          )
              : null,
        ),
      ),
    );
  }
}