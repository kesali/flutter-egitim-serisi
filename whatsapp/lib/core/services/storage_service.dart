import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  Future<StorageReference> uploadFile(File file) async {
    var uploadTask = _firebaseStorage
        .ref()
        .child(
            "${DateTime.now().millisecondsSinceEpoch.toString()}.${file.path.split(".").last}")
        .putFile(file);

    uploadTask.events.listen((event) {
      print(event);
    });

    var snapShot = await uploadTask.onComplete;

    return snapShot.ref;
  }
}
