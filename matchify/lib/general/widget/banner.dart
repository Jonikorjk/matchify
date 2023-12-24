import 'package:flutter/material.dart';

class GeneralBanner extends StatelessWidget {
  const GeneralBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        color: Colors.transparent,
        child: Container(
          color: Colors.transparent,
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Best player",
                textDirection: TextDirection.ltr,
                style: TextStyle(fontSize: 24),
              ),
              Image.asset(
                'assets/images/banner_1.jpeg',
                width: 250,
                height: 350,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
