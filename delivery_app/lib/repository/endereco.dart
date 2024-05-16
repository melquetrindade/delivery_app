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
  late Endereco _endereco;
  Endereco _dbFirebase = Endereco(
      rua: 'Brasilino Gomes Meira',
      bairro: 'Maria Terceira',
      num: '311',
      complemento: 'Casa',
      referencia: 'Por trás da quadra do Maria Terceira');

  EnderecoRepository() {
    iniciarState();
  }

  Endereco get endereco => _endereco;

  iniciarState() {
    _endereco = _dbFirebase;
  }

  addEndereco() {}

  deleteEndereco() {}

  updateEndereco(Endereco newEndereco) {
    _dbFirebase = newEndereco;
    _endereco = newEndereco;

    notifyListeners();
  }
}
