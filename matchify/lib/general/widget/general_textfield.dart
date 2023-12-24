import 'package:matchify/general/theme_colors.dart';
import 'package:flutter/material.dart';

class GeneralTextField extends StatelessWidget {
  final String labelText;
  final String? errorText;
  final void Function(String)? onChanged;
  final TextInputType? textInputType;
  final TextEditingController? controller;

  const GeneralTextField(
      {super.key,
      this.labelText = "",
      this.errorText,
      this.onChanged,
      this.textInputType,
      this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      controller: controller,
      style: const TextStyle(color: Colors.white),
      keyboardType: textInputType,
      decoration: InputDecoration(
        hintText: null,
        errorText: errorText,
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          borderSide: BorderSide(color: Colors.white),
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          borderSide: BorderSide.none,
        ),
        labelText: labelText,
        filled: true,
        fillColor: ThemeColors.subBackgroundColor,
        labelStyle: TextStyle(color: Colors.white.withOpacity(0.4)),
        floatingLabelBehavior: FloatingLabelBehavior.never,
      ),
    );
  }
}
