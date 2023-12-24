import 'package:matchify/general/theme_colors.dart';
import 'package:flutter/material.dart';

enum ThemeButtonType { filled, bordered }

class ThemeButton extends StatelessWidget {
  final double width;
  final double height;
  final ThemeButtonType buttonType;
  final void Function()? onPressed;
  final double fontSize;
  final String title;
  final Color color;

  const ThemeButton({
    super.key,
    required this.width,
    required this.height,
    required this.buttonType,
    this.fontSize = 24,
    this.onPressed,
    this.color = const Color.fromRGBO(100, 130, 188, 1),
    this.title = 'Default title',
  });

  @override
  Widget build(BuildContext context) {
    switch (buttonType) {
      case ThemeButtonType.bordered:
        return SizedBox(
          width: width,
          height: height,
          child: OutlinedButton(
            onPressed: onPressed,
            style: OutlinedButton.styleFrom(
              side: const BorderSide(
                width: 3,
                color: Color.fromRGBO(100, 130, 188, 1),
              ),
              textStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
              backgroundColor: ThemeColors.backgroundColor,
            ),
            child: Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: fontSize,
                fontWeight: FontWeight.w600,
              ),
              textDirection: TextDirection.ltr,
            ),
          ),
        );

      case ThemeButtonType.filled:
        return SizedBox(
          width: width,
          height: height,
          child: OutlinedButton(
            onPressed: onPressed,
            style: OutlinedButton.styleFrom(
              textStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.w600,
              ),
              backgroundColor: color,
            ),
            child: Text(
              title,
              style: TextStyle(
                fontSize: fontSize,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
              textDirection: TextDirection.ltr,
            ),
          ),
        );
    }
  }
}
