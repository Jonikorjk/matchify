import 'package:flutter/material.dart';

class BottomButton extends StatelessWidget {
  final void Function()? onPressed;
  final String title;
  final double width;
  final double height;

  const BottomButton({
    super.key,
    this.onPressed,
    required this.title,
    this.width = 0,
    this.height = 50,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 40, right: 40, bottom: 50),
      child: SizedBox(
        height: 50,
        width: MediaQuery.of(context).size.width,
        child: OutlinedButton(
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
            textStyle:
                const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
            backgroundColor: const Color.fromRGBO(100, 130, 188, 1),
          ),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
            textDirection: TextDirection.ltr,
          ),
        ),
      ),
    );
  }
}
