import 'package:flutter/material.dart';

class YellowCardWidget extends StatelessWidget {
  const YellowCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        shadowColor: Colors.transparent,
      ),
      body: Container(
        color: Colors.yellow,
      ),
    );
  }
}
