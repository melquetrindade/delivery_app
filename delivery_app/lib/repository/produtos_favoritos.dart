import 'package:delivery_app/models/produto.dart';
import 'package:delivery_app/repository/acai.dart';
import 'package:delivery_app/repository/bebida.dart';
import 'package:delivery_app/repository/favoritos.dart';
import 'package:delivery_app/repository/hamburguer.dart';
import 'package:delivery_app/repository/hotDog.dart';
import 'package:delivery_app/repository/milkShakers.dart';
import 'package:delivery_app/repository/pizza.dart';
import 'package:flutter/material.dart';

class ProdutosFavoritosRepository extends ChangeNotifier {
  List<Produto> _produtos = [];
  List<Produto> _testeP = [];

  final List<Function> _funcoes = [
    () => HamburguerRepository().hamburguer,
    () => PizzaRepository().pizzas,
    () => HotDogRepository().hotdog,
    () => AcaiRepository().acai,
    () => MilkShakersRepository().milkshakers,
    () => BebidaRepository().bebida,
  ];
  final List<FavoriteProducts> _dbFirebase = [
    FavoriteProducts('McNífico Bacon', 'Hambúrguer'),
    FavoriteProducts('Calabresa', 'Pizza'),
    FavoriteProducts('Dog Simples', 'HotDog'),
    FavoriteProducts('Açaí Tradicional', 'Açaí'),
    FavoriteProducts('Milk Shake Kopenhagen', 'MilkShakers'),
    FavoriteProducts('Coca-Cola Lata', 'Bebida'),
  ];

  List<Produto> get listaProdutos => _produtos;
  List<Produto> get listaTestP => _testeP;

  ProdutosFavoritosRepository() {
    iniciarState();
  }

  iniciarState() {
    _funcoes.asMap().forEach((index, element) {
      var response = _funcoes[index]();
      for (int i = 0; i < response.length; i++) {
        if (_dbFirebase.any((fav) =>
            fav.nome == response[i].nome &&
            fav.categoria == response[i].categoria)) {
          _produtos.add(response[i]);
        }
        ;
      }
    });
  }

  saveProduto(Produto produto) {
    print('clicou para favoritar no favoritos');
    //print('-- $produto --');
    _testeP = _produtos;
    _testeP.add(produto);
    //print(_produtos.length);

    notifyListeners();
  }

  removeProduto(Produto produto) {
    print('clicou para desfavoritar no favoritos');
    //print('-- $produto --');
    _testeP = _produtos;
    _testeP.removeWhere((item) => item.nome == produto.nome);
    //print(_produtos.length);

    notifyListeners();
  }
}
