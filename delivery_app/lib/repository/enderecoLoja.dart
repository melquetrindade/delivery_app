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

class Horario {
  String dia;
  String abre;
  String fecha;
  bool status;

  Horario(
      {required this.dia,
      required this.abre,
      required this.fecha,
      required this.status});
}

class EnderecoLojaRepository extends ChangeNotifier {
  late EnderecoLoja _endereco =
      EnderecoLoja(rua: '', cidade: '', bairro: '', num: '', frete: 0);
  late List<Horario> _horarios = [];
  late List<String> _telefones = [];
  late FirebaseFirestore db;
  bool loading = true;
  bool jaCarregou = false;
  List<String> dias = [
    'segunda',
    'terca',
    'quarta',
    'quinta',
    'sexta',
    'sabado',
    'domingo'
  ];

  EnderecoLojaRepository() {
    iniciarState();
  }

  EnderecoLoja get enderecoLoja => _endereco;
  List<Horario> get horariosLoja => _horarios;
  List<String> get telefonesLoja => _telefones;

  _startFirestore() {
    db = DBFirestore.get();
  }

  iniciarState() async {
    await _startFirestore();
    await readEndereco();
    await readHorarios();
    await readTelefones();
  }

  readTelefones() async {
    final snapshot = await db.collection('loja/configuracoes/contato').get();
    if(snapshot.docs.length != 0){
      snapshot.docs.forEach((item) {
        _telefones.add(item['telefone']);
      });
    }
    notifyListeners();
  }

  readEndereco() async {
    final snapshot = await db
        .collection('loja/configuracoes/endereco')
        .doc('endereco')
        .get();
    if (snapshot.exists) {
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

  readHorarios() async {
    final snapshot = await db
        .collection('loja/configuracoes/horarios')
        .doc('horarios')
        .get();
    if (snapshot.exists) {
      dias.forEach((itemDia) {
        if (snapshot[itemDia]['status'] == true) {
          _horarios.add(Horario(
              dia: itemDia,
              abre: snapshot[itemDia]['abre'],
              fecha: snapshot[itemDia]['fecha'],
              status: snapshot[itemDia]["status"]));
        } else {
          _horarios.add(Horario(dia: itemDia, abre: '', fecha: '', status: snapshot[itemDia]["status"]));
        }
      });
    }
    notifyListeners();
  }

  
}
