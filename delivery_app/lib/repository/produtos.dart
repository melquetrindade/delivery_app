import 'package:delivery_app/models/produto.dart';
import 'package:delivery_app/repository/acai.dart';
import 'package:delivery_app/repository/bebida.dart';
import 'package:delivery_app/repository/hamburguer.dart';
import 'package:delivery_app/repository/hotDog.dart';
import 'package:delivery_app/repository/milkShakers.dart';
import 'package:delivery_app/repository/pizza.dart';
import 'package:flutter/material.dart';

class ProdutosRepository extends ChangeNotifier {
  List<Produto> _produtos = [];
  final List<String> _categorias = [
    'Hambúrguer',
    'Pizza',
    'HotDog',
    'Açaí',
    'MilkShaker',
    'Bebidas'
  ];
  final List<Function> _funcoes = [
    () => HamburguerRepository().hamburguer,
    () => PizzaRepository().pizzas,
    () => HotDogRepository().hotdog,
    () => AcaiRepository().acai,
    () => MilkShakersRepository().milkshakers,
    () => BebidaRepository().bebida,
  ];

  List<Produto> get produto => _produtos;

  ProdutosRepository() {
    iniciarState();
  }

  iniciarState() {
    final response = HamburguerRepository().hamburguer;
    response.forEach((element) {
      _produtos.add(element);
    });
  }

  readProdutos(String categoria) {
    print('categoria: $categoria');
    if (!_produtos.isEmpty) {
      _produtos = [];
    }
    _categorias.asMap().forEach((index, element) {
      if (categoria == element) {
        final response = _funcoes[index]();
        for (var i = 0; i < response.length; i++) {
          _produtos.add(response[i]);
        }
      }
    });

    notifyListeners();
  }

  
}
