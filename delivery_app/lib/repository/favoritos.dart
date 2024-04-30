import 'package:delivery_app/models/produto.dart';
import 'package:flutter/cupertino.dart';

class FavoriteProducts {
  final String nome;
  final String categoria;

  FavoriteProducts(this.nome, this.categoria);
}

class FavoritosRepository extends ChangeNotifier {
  List<FavoriteProducts> _produtosFavoritos = [];
  final List<FavoriteProducts> _dbFirebase = [
    FavoriteProducts('McNífico Bacon', 'Hambúrguer'),
    FavoriteProducts('Calabresa', 'Pizza'),
    FavoriteProducts('Dog Simples', 'HotDog'),
    FavoriteProducts('Açaí Tradicional', 'Açaí'),
    FavoriteProducts('Milk Shake Kopenhagen', 'MilkShakers'),
    FavoriteProducts('Coca-Cola Lata', 'Bebida'),
  ];

  List<FavoriteProducts> get produtosFavoritos => _produtosFavoritos;

  FavoritosRepository() {
    iniciarState();
  }

  iniciarState() {
    _dbFirebase.forEach((element) {
      _produtosFavoritos.add(element);
    });
  }

  saveProduto(Produto produto) {
    print('clicou para favoritar');
    _dbFirebase.add(FavoriteProducts(produto.nome, produto.categoria));
    _produtosFavoritos.add(FavoriteProducts(produto.nome, produto.categoria));

    notifyListeners();
  }

  removeProduto(Produto produto) {
    print('clicou para desfavoritar');
    _dbFirebase.remove(FavoriteProducts(produto.nome, produto.categoria));
    _produtosFavoritos.remove(FavoriteProducts(produto.nome, produto.categoria));

    notifyListeners();
  }
}
