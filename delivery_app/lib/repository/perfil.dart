import 'dart:io';

import 'package:delivery_app/databases/firebase_storage.dart';
import 'package:delivery_app/services/auth_service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PerfilRepository extends ChangeNotifier {
  late FirebaseStorage storage;
  late AuthService auth;
  bool jaCarregou = false;
  bool uploading = false;
  double total = 0;

  PerfilRepository({required this.auth}) {
    iniciarState();
  }

  iniciarState() async {
    await _startFirestore();
    jaCarregou = true;
  }

  _startFirestore() {
    storage = FireStorage.get();
  }

  Future<XFile?> getImage() async {
    final ImagePicker _picker = ImagePicker();
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    return image;
  }

  Future<UploadTask> upload(String path) async {
    print('entrou no upload');
    File file = File(path);
    try {
      String ref =
          'usuarios/clientes/${auth.usuario!.uid}/image/img-${DateTime.now().toString()}.jpg';
      return storage.ref(ref).putFile(file);
    } on FirebaseException catch (e) {
      print('entrou no catch');
      throw Exception('Erro no upload: ${e.code}');
    }
  }

  pickerAndUploadImage() async {
    XFile? file = await getImage();
    if (file != null) {
      UploadTask task = await upload(file.path);

      task.snapshotEvents.listen((TaskSnapshot snapshot) {
        if (snapshot.state == TaskState.running) {
          uploading = true;
          total = (snapshot.bytesTransferred / snapshot.totalBytes) * 100;
          notifyListeners();
        } else if (snapshot.state == TaskState.success) {
          uploading = false;
          notifyListeners();
        }
      });
    }
  }
}
