import 'dart:io';

import 'package:matchify/general/helpers.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

mixin PickImage {
  Future<String> pickImageOneTime() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return "";
      final imageFile = File(image.path);
      return base64EncodeImageFile(imageFile);
    } on PlatformException {
      return "";
    }
  }

  Future<List<String>> pickImageMultiplieTimes() async {
    try {
      final images = await ImagePicker().pickMultiImage();
      if (images.isEmpty) return [];
      var imageFiles = images.map((image) => File(image.path));
      var base64StringImages = List<String>.empty(growable: true);
      for (var imageFile in imageFiles) {
        base64StringImages.add(base64EncodeImageFile(imageFile));
      }
      return base64StringImages;
    } on PlatformException {
      return [];
    }
  }
}
