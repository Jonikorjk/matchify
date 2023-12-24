import 'package:matchify/general/helpers.dart';
import 'package:flutter/material.dart';

class PlayerImageWidget extends StatelessWidget {
  final double width;
  final double height;
  final void Function()? onPressed;
  final String image;

  const PlayerImageWidget({
    super.key,
    required this.width,
    required this.height,
    required this.image,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: IconButton(
        onPressed: onPressed,
        icon: decodeBase64ImageString(image, width, height, BoxFit.cover),
      ),
    );
  }
}
