import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    required this.controller,
    required this.hintText,
    required this.isObscure,
    required this.suffixIcon,
    super.key,
    this.validator,
  });

  final TextEditingController controller;
  final bool isObscure;
  final String hintText;
  final Widget suffixIcon;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      obscureText: isObscure,
      obscuringCharacter: '*',
      decoration: InputDecoration(
        fillColor: const Color(0xFFF7F8F9),
        filled: true,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(color: Color(0xFFE8ECF4), width: 1),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(color: Color(0xFFE8ECF4), width: 1),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(color: Color(0xFFE8ECF4), width: 1),
        ),
        contentPadding: const EdgeInsets.only(left: 17),
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Color(0xFF8391A1),
          fontSize: 15,
          fontWeight: FontWeight.w500,
          fontFamily: 'Urbanist',
        ),
        suffixIcon: suffixIcon,
      ),
    );
  }
}
