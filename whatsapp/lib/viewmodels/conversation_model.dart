import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:whatsapp_clone/core/services/storage_service.dart';

import '../locator.dart';
import 'base_model.dart';

class ConversationModel extends BaseModel {
  final StorageService _storageService = getIt<StorageService>();
  final ImagePicker _picker = ImagePicker();
  String uploadedMedia = "";
  CollectionReference _ref;

  Stream<QuerySnapshot> getConversation(String id) {
    _ref = Firestore.instance.collection('conversations/$id/messages');

    return _ref.orderBy('timeStamp').snapshots();
  }

  Future<void> add(Map<String, dynamic> data) async {
    await _ref.add(data);

    uploadedMedia = '';

    notifyListeners();
  }

  Future<void> uploadMedia(ImageSource source) async {
    var pickedFile = await _picker.getImage(source: source);

    if (pickedFile == null) return null;

    var file = await _storageService.uploadFile(File(pickedFile.path));

    uploadedMedia = await file.getDownloadURL();

    notifyListeners();
  }
}
