import 'dart:async';
import 'package:matchify/main.dart';
import 'package:flutter/material.dart';

class BannersManager {
  final BuildContext _context;
  BannersManager(this._context) {
    showBanner();
  }

  void showBanner() async {
    var status = await appManager.settingsManager.getBannersStatus() ?? true;

    if (!status) return;

    Timer(
      const Duration(seconds: 3),
      () {
        showDialog(
          context: _context,
          builder: (context) {
            return _setupBanner();
          },
        );
      },
    );
  }

  AlertDialog _setupBanner() {
    Widget okButton = TextButton(
      child: const Text(
        "Agree",
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      onPressed: () {
        Navigator.of(_context).pop();
      },
    );

    return AlertDialog(
      alignment: Alignment.center,
      title: const Text(
        'Best player',
        style: TextStyle(
          color: Colors.white,
          backgroundColor: Colors.transparent,
        ),
      ),
      icon: Image.asset(
        'assets/images/messi.png',
        width: 200,
        height: 300,
      ),
      actions: [
        Align(
          alignment: Alignment.bottomCenter,
          child: okButton,
        ),
      ],
    );
  }
}
