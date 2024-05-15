import 'package:flutter/material.dart';

class EnderecoLoja {
  String rua;
  String cidade;
  String bairro;
  String num;
  String complemento;
  double frete;

  EnderecoLoja(
    {required this.rua,
    required this.cidade,
    required this.bairro,
    required this.num,
    required this.complemento,
    required this.frete
  });
}

class EnderecoLojaRepository extends ChangeNotifier {
  late EnderecoLoja _endereco;
  EnderecoLoja _dbFirebase = EnderecoLoja(
    rua: '7 de Setembro',
    cidade: 'Parelhas',
    bairro: 'Centro',
    num: '91',
    complemento: 'Casa',
    frete: 5.0
  );

  EnderecoLojaRepository() {
    iniciarState();
  }

  EnderecoLoja get enderecoLoja => _endereco;

  iniciarState() {
    _endereco = _dbFirebase;
  }

  addEndereco() {}

  deleteEndereco() {}

  updateEndereco() {}
}
