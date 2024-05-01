import 'package:delivery_app/models/produto.dart';
import 'package:delivery_app/repository/produtos_favoritos.dart';
import 'package:flutter/cupertino.dart';

class FavoriteProducts {
  final String nome;
  final String categoria;

  FavoriteProducts(this.nome, this.categoria);
}

class FavoritosRepository extends ChangeNotifier {
  List<FavoriteProducts> _produtosFavoritos = [];
  ProdutosFavoritosRepository productsFavorites = ProdutosFavoritosRepository();
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
    //print('clicou para favoritar');
    
    _dbFirebase.add(FavoriteProducts(produto.nome, produto.categoria));
    _produtosFavoritos.add(FavoriteProducts(produto.nome, produto.categoria));
    
    notifyListeners();
  }

  removeProduto(Produto produto) {
    //print('clicou para desfavoritar');
    
    _dbFirebase.removeWhere((item) => item.nome == produto.nome);
    _produtosFavoritos.removeWhere((item) => item.nome == produto.nome);
    

    notifyListeners();
  }
}
