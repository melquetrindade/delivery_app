import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app/databases/db_firestore.dart';
import 'package:flutter/material.dart';

class EnderecoLoja {
  String rua;
  String cidade;
  String bairro;
  String num;
  double frete;

  EnderecoLoja(
      {required this.rua,
      required this.cidade,
      required this.bairro,
      required this.num,
      required this.frete});
}

class EnderecoLojaRepository extends ChangeNotifier {
  late EnderecoLoja _endereco =
      EnderecoLoja(rua: '', cidade: '', bairro: '', num: '', frete: 0);
  late FirebaseFirestore db;
  bool loading = true;
  bool jaCarregou = false;

  EnderecoLojaRepository() {
    iniciarState();
  }

  EnderecoLoja get enderecoLoja => _endereco;

  _startFirestore() {
    db = DBFirestore.get();
  }

  iniciarState() async {
    //loading = true;
    //_endereco = _dbFirebase;
    await _startFirestore();
    await readEndereco();
    //loading = false;
  }

  readEndereco() async {
    final snapshot = await db
        .collection('loja/configuracoes/endereco')
        .doc('endereco')
        .get();
    if (snapshot.exists) {
      //print(snapshot['bairro']);
      _endereco = EnderecoLoja(
        bairro: snapshot['bairro'],
        cidade: snapshot['cidade'],
        num: snapshot['num'],
        rua: snapshot['rua'],
        frete: double.parse(snapshot['frete'].replaceAll(',', '.')),
      );
    } else {
      _endereco =
          EnderecoLoja(bairro: '', cidade: '', frete: 0, num: '', rua: '');
    }

    notifyListeners();
  }
}
