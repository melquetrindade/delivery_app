import 'package:firebase_storage/firebase_storage.dart';

class FireStorage {
  FireStorage._();

  static final FireStorage _instance = FireStorage._();
  final FirebaseStorage _firestore = FirebaseStorage.instance;

  static FirebaseStorage get() {
    return FireStorage._instance._firestore;
  }
}