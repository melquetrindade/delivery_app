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

  Future<void> upload(String path) async {
    File file = File(path);
    try {
      String ref =
          'usuarios/clientes/${auth.usuario!.uid}/image/img-${DateTime.now().toString()}';
      await storage.ref(ref).putFile(file);
    } on FirebaseException catch (e) {
      throw Exception('Erro no upload: ${e.code}');
    }
  }
}
