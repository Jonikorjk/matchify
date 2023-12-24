import 'package:matchify/general/assets.dart';
import 'package:matchify/general/helpers.dart';
import 'package:matchify/general/theme_colors.dart';
import 'package:flutter/material.dart';

class AddPlayerButton extends StatelessWidget {
  final double width;
  final double height;
  final void Function()? onPressed;

  const AddPlayerButton({
    super.key,
    required this.width,
    required this.height,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      color: backgroundColor,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: ThemeColors.buttonBackgroundColor,
        ),
        onPressed: onPressed,
        child: Image.asset(Assets.plusImage),
      ),
    );
  }
}
