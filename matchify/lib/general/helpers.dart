import 'dart:convert';
import 'dart:io';

import 'package:flutter/widgets.dart';

Color get backgroundColor => const Color.fromRGBO(33, 33, 33, 1);

String base64EncodeImageFile(File file) {
  List<int> imageBytes = file.readAsBytesSync();
  return base64Encode(imageBytes);
}

Image decodeBase64ImageString(
    String base64String, double width, double height, BoxFit? fit) {
  if (base64String.isEmpty) {
    return Image.asset(
      'assets/images/messi.png',
      fit: fit,
      width: width,
      height: height,
    );
  }
  return Image.memory(
    base64Decode(base64String),
    width: width,
    height: height,
    fit: fit,
  );
}
