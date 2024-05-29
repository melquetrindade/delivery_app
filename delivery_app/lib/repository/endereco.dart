import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app/databases/db_firestore.dart';
import 'package:delivery_app/services/auth_service.dart';
import 'package:flutter/material.dart';

class Endereco {
  String rua;
  String bairro;
  String num;
  String complemento;
  String referencia;

  Endereco(
      {required this.rua,
      required this.bairro,
      required this.num,
      required this.complemento,
      required this.referencia});
}

class EnderecoRepository extends ChangeNotifier {
  Endereco _endereco = Endereco(rua: '', bairro: '', num: '', complemento: '', referencia: '');
  late FirebaseFirestore db;
  late AuthService auth;
  bool loading = true;
  bool jaCarregou = false;

  EnderecoRepository({required this.auth}) {
    iniciarState();
  }

  Endereco get endereco => _endereco;

  iniciarState() async {
    await _startFirestore();
    await _readFavoritos();
    jaCarregou = true;
  }

  _startFirestore() {
    db = DBFirestore.get();
  }

  setLista() {
    print('entrou no setLista');
    _endereco =
        Endereco(rua: '', bairro: '', num: '', complemento: '', referencia: '');
    _readFavoritos();
  }

  _readFavoritos() async {
    loading = true;
    if (auth.usuario != null) {
      final snapshot = await db
          .collection('loja/usuarios/clientes/${auth.usuario!.uid}/endereco')
          .get();

      if (snapshot.docs.length == 1) {
        snapshot.docs.forEach((item) {
          _endereco = Endereco(
              rua: item['rua'],
              bairro: item['bairro'],
              num: item['num'],
              complemento: item['complemento'],
              referencia: item['referencia']);
        });
      } else {
        _endereco = Endereco(
            rua: '', bairro: '', num: '', complemento: '', referencia: '');
      }
    }
    loading = false;
    notifyListeners();
  }

  addEndereco(Endereco newEndereco) async {
    final qtd = await db
        .collection('loja/usuarios/clientes/${auth.usuario!.uid}/endereco')
        .get();

    _endereco = newEndereco;
    await db
        .collection('loja/usuarios/clientes/${auth.usuario!.uid}/endereco')
        .doc((qtd.size + 1).toString())
        .set({
      'rua': newEndereco.rua,
      'bairro': newEndereco.bairro,
      'num': newEndereco.num,
      'complemento': newEndereco.complemento,
      'referencia': newEndereco.referencia
    });

    notifyListeners();
  }

  deleteEndereco() {}

  updateEndereco(Endereco newEndereco) async {
    final qtd = await db
        .collection('loja/usuarios/clientes/${auth.usuario!.uid}/endereco')
        .get();

    _endereco = newEndereco;
    await db
        .collection('loja/usuarios/clientes/${auth.usuario!.uid}/endereco')
        .doc((qtd.size).toString())
        .update({
      'rua': newEndereco.rua,
      'bairro': newEndereco.bairro,
      'num': newEndereco.num,
      'complemento': newEndereco.complemento,
      'referencia': newEndereco.referencia
    });

    notifyListeners();
  }
}

/*
  Endereco _dbFirebase = Endereco(
      rua: 'Brasilino Gomes Meira',
      bairro: 'Maria Terceira',
      num: '311',
      complemento: 'Casa',
      referencia: 'Por trás da quadra do Maria Terceira');*/