import 'package:flutter/material.dart';

class GeneralText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final TextAlign? textAlign;
  final Color color;

  const GeneralText({
    super.key,
    required this.text,
    this.fontSize = 20,
    this.textAlign,
    this.color = Colors.white,
    this.fontWeight = FontWeight.w400,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: fontSize,
        color: color,
      ),
      textDirection: TextDirection.ltr,
    );
  }
}
