import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:whatsapp_clone/core/services/storage_service.dart';

import '../core/locator.dart';
import 'base_model.dart';

class ConversationModel extends BaseModel {
  final StorageService _storageService = getIt<StorageService>();
  CollectionReference _ref;
  String mediaUrl = '';

  Stream<QuerySnapshot> getConversation(String id) {
    _ref = FirebaseFirestore.instance.collection('conversations/$id/messages');

    return _ref.orderBy('timeStamp').snapshots();
  }

  Future<DocumentReference> add(Map<String, dynamic> data) {
    mediaUrl = '';

    notifyListeners();

    return _ref.add(data);
  }

  uploadMedia(ImageSource source) async {
    var pickedFile = await ImagePicker().getImage(source: source);

    if (pickedFile == null) return;

    mediaUrl = await _storageService.uploadMedia(File(pickedFile.path));

    notifyListeners();
  }
}
