import 'package:matchify/general/widget/add_player_button.dart';
import 'package:flutter/cupertino.dart';

class SelectPlayersWidget extends StatelessWidget {
  const SelectPlayersWidget({
    super.key,
    required this.width,
    required this.height,
    required this.onPressed,
  });

  final double width;
  final double height;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return AddPlayerButton(
      width: width,
      height: height,
      onPressed: onPressed,
    );
  }
}
