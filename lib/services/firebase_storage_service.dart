import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:url_launcher/url_launcher.dart';

class FirebaseStorageService {
  static Future<String> uploadFile(File file) async {
    final storageRef = FirebaseStorage.instance
        .ref()
        .child('book_covers')
        .child('${DateTime.now().millisecondsSinceEpoch}');

    final uploadTask = storageRef.putFile(file);

    await uploadTask.whenComplete(() => null);

    return storageRef.getDownloadURL();
  }
}
