import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class FilesPicking {
  static Future<File?> pickImageFromGallery() async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      var image = null;
      if (pickedFile != null) {
        image = File(pickedFile.path);
        return image;
      } else {
        print('No image selected.');
        return null;
      }
    } on PlatformException catch (e) {
      print("Failed to pick image: $e");
    }
  }

  static Future<File?> pickImageFromCamera() async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.camera);
      var image = null;
      if (pickedFile != null) {
        image = File(pickedFile.path);
        return image;
      } else {
        print('No image selected.');
        return null;
      }
    } on PlatformException catch (e) {
      print("Failed to pick image: $e");
    }
  }

  static Future<File?> pickSingleFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      File file = File(result.files.single.path as String);
      return file;
    } else {
      return null;
    }
  }

  static Future<List<File>?> pickMultipleFiles(List<String> listAllowed) async {
    FilePickerResult? result ;
    if (listAllowed.isEmpty) {
      result = await FilePicker.platform.pickFiles(allowMultiple: true);
    } else {
      result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: listAllowed,
      );
    }
    if (result != null) {
      List<File> files = result.paths.map((path) => File(path as String)).toList();
      return files;
    } else {
      return null;
    }
  }
}
