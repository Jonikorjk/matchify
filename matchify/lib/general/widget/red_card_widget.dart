import 'package:flutter/material.dart';

class RedCardWidget extends StatelessWidget {
  const RedCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        shadowColor: Colors.transparent,
      ),
      body: Container(
        color: Colors.red,
      ),
    );
  }
}
