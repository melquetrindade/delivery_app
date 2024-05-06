import 'package:delivery_app/models/produto.dart';
import 'package:flutter/material.dart';

class CarrinhoRepository extends ChangeNotifier {
  List<Produto> _carrinho = [];
  List<Produto> _dbFirebase = [
    Produto(
        'McNífico Bacon',
        'assets/hamburguer/mcNificoBacon.png',
        'Um hambúrguer (carne 100% bovina), bacon, alface americana, cebola, queijo processado sabor cheddar, tomate, maionese, ketchup, mostarda e pão com gergelim.',
        'Hambúrguer',
        13.99),
    Produto(
        'Calabresa',
        'assets/pizza/calabresa.jpg',
        'Desfrute do clássico sabor refrescante da Coca-Cola em uma lata conveniente de 330ml.',
        'Pizza',
        32.99),
    Produto(
        'Coca-Cola Lata',
        'assets/bebidas/coca_lata.jpg',
        'Um hambúrguer (carne 100% bovina), bacon, alface americana, cebola, queijo processado sabor cheddar, tomate, maionese, ketchup, mostarda e pão com gergelim.',
        'Bebida',
        4.00),
  ];

  CarrinhoRepository() {
    iniciarState();
  }

  List<Produto> get objCarrinho => _carrinho;

  iniciarState() {
    _dbFirebase.forEach((element) {
      _carrinho.add(element);
    });
  }

  addProduto(Produto produto) {
    print('add ao carrinho');
    _dbFirebase.add(produto);
    _carrinho.add(produto);

    print(_carrinho.length);
    
    notifyListeners();
  }

  deleteProduto(Produto produto) {
    _dbFirebase.removeWhere((element) => element.nome == produto.nome);
    _carrinho.removeWhere((element) => element.nome == produto.nome);

    notifyListeners();
  }
}
