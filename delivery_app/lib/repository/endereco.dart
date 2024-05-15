import 'package:flutter/material.dart';

class Endereco {
  String rua;
  String bairro;
  String num;
  String complemento;

  Endereco(
      {required this.rua,
      required this.bairro,
      required this.num,
      required this.complemento});
}

class EnderecoRepository extends ChangeNotifier {
  late Endereco _endereco;
  Endereco _dbFirebase = Endereco(
      rua: 'Brasilino Gomes Meira',
      bairro: 'Maria Terceira',
      num: '311',
      complemento: 'Casa');

  EnderecoRepository() {
    iniciarState();
  }

  Endereco get endereco => _endereco;

  iniciarState() {
    _endereco = _dbFirebase;
  }

  addEndereco(){}

  deleteEndereco(){}

  updateEndereco(){}

}
