import 'package:matchify/general/widget/add_player_button.dart';
import 'package:matchify/general/widget/player_image_widget.dart';
import 'package:flutter/material.dart';

class AddPlayerWidget extends StatelessWidget {
  final double width;
  final double height;
  final String base64StringImage;
  final void Function()? onPressed;

  const AddPlayerWidget({
    super.key,
    this.width = 165,
    this.height = 90,
    this.onPressed,
    this.base64StringImage = "",
  });

  @override
  Widget build(BuildContext context) {
    if (base64StringImage.isNotEmpty) {
      return PlayerImageWidget(
        width: width,
        height: height,
        image: base64StringImage,
        onPressed: onPressed,
      );
    }
    return AddPlayerButton(
      width: width,
      height: height,
      onPressed: onPressed,
    );
  }
}
