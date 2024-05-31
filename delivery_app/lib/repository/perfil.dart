import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app/databases/db_firestore.dart';
import 'package:delivery_app/databases/firebase_storage.dart';
import 'package:delivery_app/services/auth_service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PerfilRepository extends ChangeNotifier {
  String _imgProfile = '';
  late FirebaseStorage storage;
  late FirebaseFirestore db;
  late AuthService auth;
  bool jaCarregou = false;
  bool uploading = false;
  double total = 0;
  bool loading = true;
  List<Reference> refs = [];
  List<String> arquivo = [];

  PerfilRepository({required this.auth}) {
    iniciarState();
  }

  String get imgProfile => _imgProfile;

  iniciarState() async {
    await _startFireStorage();
    await _startFirestore();
    await _readImageProfile();
    jaCarregou = true;
  }

  _startFireStorage() {
    storage = FireStorage.get();
  }

  _startFirestore() {
    db = DBFirestore.get();
  }

  setImg() {
    print('entrou no setImg');
    _imgProfile = '';
    _readImageProfile();
  }

  _readImageProfile() async {
    loading = true;
    final snapshot = await db
        .collection('loja/usuarios/clientes/${auth.usuario!.uid}/imgProfile')
        .get();

    if (snapshot.docs.length == 1) {
      _imgProfile = snapshot.docs[0]['img'];
    }
    loading = false;
    notifyListeners();
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
          addImgFirestore();
          uploading = false;
          notifyListeners();
        }
      });
    }
  }

  addImgFirestore() async {
    refs = (await storage
            .ref('usuarios/clientes/${auth.usuario!.uid}/image')
            .listAll())
        .items;
    for (var ref in refs) {
      arquivo.add(await ref.getDownloadURL());
    }

    if (refs.length == 1) {
      print('refs == 1');
      await db
          .collection('loja/usuarios/clientes/${auth.usuario!.uid}/imgProfile')
          .doc('img')
          .set({'img': arquivo[0]});
      _imgProfile = arquivo[0];
    }
    notifyListeners();
  }

  deleteImage() async {
    print('qtd do refs: ${refs.length}');
    refs = [];
    arquivo = [];
    refs = (await storage
            .ref('usuarios/clientes/${auth.usuario!.uid}/image')
            .listAll())
        .items;
    await storage.ref(refs[0].fullPath).delete();
    await db
        .collection('loja/usuarios/clientes/${auth.usuario!.uid}/imgProfile')
        .doc('img')
        .delete();
    _imgProfile = '';
    notifyListeners();
  }
}
