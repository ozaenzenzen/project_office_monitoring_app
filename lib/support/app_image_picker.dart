import 'dart:convert';
import 'dart:io';

import 'package:image_picker/image_picker.dart';

class AppImagePickerService {
  static final ImagePicker _picker = ImagePicker();

  static Future<XFile?> getImage({
    ImageSource imageSource = ImageSource.gallery,
  }) async {
    final XFile? image = await _picker.pickImage(
      // source: ImageSource.gallery,
      source: imageSource,
      preferredCameraDevice: CameraDevice.rear,
    );
    return image;
  }

  static Future<String?> getImageAsBase64({
    ImageSource imageSource = ImageSource.gallery,
  }) async {
    try {
      final XFile? image = await _picker.pickImage(
        // source: ImageSource.gallery,
        source: imageSource,
        preferredCameraDevice: CameraDevice.rear,
        imageQuality: 20,
      );
      File fileFormat = File(image!.path);
      String base64Image = base64Encode(fileFormat.readAsBytesSync());
      return base64Image;
    } catch (e) {
      return null;
    }
  }

  static Future<File?> getImageAsFile({
    ImageSource imageSource = ImageSource.gallery,
  }) async {
    try {
      final XFile? image = await _picker.pickImage(
        // source: ImageSource.gallery,
        source: imageSource,
        preferredCameraDevice: CameraDevice.rear,
        imageQuality: 30,
        maxHeight: 400,
        maxWidth: 400,
      );
      File fileFormat = File(image!.path);
      return fileFormat;
    } catch (e) {
      return null;
    }
  }
}
