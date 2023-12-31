import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'models/universal_data.dart';

class FileUploader {
  static Future<UniversalReponse> imageUploader(XFile xFile) async {
    String downloadUrl = "";
    try {
      final storageRef = FirebaseStorage.instance.ref();
      var imageRef = storageRef.child("images/profileImages/$xFile");
      await imageRef.putFile(File(xFile.path));
      downloadUrl = await imageRef.getDownloadURL();

      return UniversalReponse(data: downloadUrl);
    } catch (error) {
      return UniversalReponse(error: error.toString());
    }
  }





  static Future<String> fileUploader(File file, String fileName) async {
    String downloadUrl = "";
    final storageRef = FirebaseStorage.instance.ref();
    var imageRef = storageRef.child("files/pdf/$fileName");
    await imageRef.putFile(File(file.path));
    downloadUrl = await imageRef.getDownloadURL();
    return downloadUrl;
  }
}