import 'package:delivery_app/models/produto.dart';
import 'package:flutter/material.dart';

class ItemCarrinho {
  Produto itemProduto;
  int qtd;
  String tamanho;

  double calcItemCarrinho() {
    return itemProduto.valor * qtd;
  }

  ItemCarrinho(
      {required this.itemProduto, this.qtd = 0, this.tamanho = 'null'});
}

class CarrinhoRepository extends ChangeNotifier {
  List<ItemCarrinho> _carrinho = [];
  List<ItemCarrinho> _dbFirebase = [
    ItemCarrinho(
        itemProduto: Produto(
            'McNífico Bacon',
            'assets/hamburguer/mcNificoBacon.png',
            'Um hambúrguer (carne 100% bovina), bacon, alface americana, cebola, queijo processado sabor cheddar, tomate, maionese, ketchup, mostarda e pão com gergelim.',
            'Hambúrguer',
            13.99),
        qtd: 1,
        tamanho: 'null'),
    ItemCarrinho(
        itemProduto: Produto(
            'Calabresa',
            'assets/pizza/calabresa.jpg',
            'Desfrute do clássico sabor refrescante da Coca-Cola em uma lata conveniente de 330ml.',
            'Pizza',
            32.99),
        qtd: 1,
        tamanho: 'P'),
    ItemCarrinho(
        itemProduto: Produto(
            'Coca-Cola Lata',
            'assets/bebidas/coca_lata.jpg',
            'Um hambúrguer (carne 100% bovina), bacon, alface americana, cebola, queijo processado sabor cheddar, tomate, maionese, ketchup, mostarda e pão com gergelim.',
            'Bebida',
            4.00),
        qtd: 1,
        tamanho: 'null')
  ];

  CarrinhoRepository() {
    iniciarState();
  }

  List<ItemCarrinho> get objCarrinho => _carrinho;

  iniciarState() {
    _dbFirebase.forEach((element) {
      _carrinho.add(element);
    });
  }

  addProduto(ItemCarrinho produto) {
    List<ItemCarrinho> hasAdd = [];
    int id = 0;
    if (produto.itemProduto.categoria == 'Pizza') {
      _carrinho.asMap().forEach((index, item) {
        if (item.itemProduto.nome == produto.itemProduto.nome &&
            item.tamanho == produto.tamanho) {
          hasAdd.add(item);
          id = index;
        }
      });
      if (!hasAdd.isEmpty) {
        print('entrou no de pizza');
        _carrinho[id].qtd++;
        _dbFirebase[id].qtd = _carrinho[id].qtd;
      } else {
        _dbFirebase.add(produto);
        _carrinho.add(produto);
      }
    } else {
      _carrinho.asMap().forEach((index, item) {
        if (item.itemProduto.nome == produto.itemProduto.nome) {
          hasAdd.add(item);
          id = index;
        }
      });
      if (!hasAdd.isEmpty) {
        print('entrou no que não é pizza');
        _carrinho[id].qtd++;
        _dbFirebase[id].qtd = _carrinho[id].qtd;
      } else {
        _dbFirebase.add(produto);
        _carrinho.add(produto);
      }
    }
    //_dbFirebase.where((item) => item.itemProduto.nome == produto.nome).toList();

    notifyListeners();
  }

  deleteProduto(ItemCarrinho produto) {
    //_dbFirebase.removeWhere((element) => element.nome == produto.nome);
    //_carrinho.removeWhere((element) => element.nome == produto.nome);

    int id = 0;
    if (produto.itemProduto.categoria == 'Pizza') {
      _carrinho.asMap().forEach((index, item) {
        if (item.itemProduto.nome == produto.itemProduto.nome &&
            item.tamanho == produto.tamanho) {
          id = index;
        }
      });

      _carrinho[id].qtd--;
      if (_carrinho[id].qtd == 0) {
        _carrinho.removeAt(id);
        _dbFirebase.removeAt(id);
      } else {
        _dbFirebase[id].qtd = _carrinho[id].qtd;
      }
    } else {
      _carrinho.asMap().forEach((index, item) {
        if (item.itemProduto.nome == produto.itemProduto.nome) {
          id = index;
        }
      });

      _carrinho[id].qtd--;
      if (_carrinho[id].qtd == 0) {
        _carrinho.removeAt(id);
        _dbFirebase.removeAt(id);
      } else {
        _dbFirebase[id].qtd = _carrinho[id].qtd;
      }
    }

    notifyListeners();
  }

  clearCarrinho() {
    _dbFirebase = [];
    _carrinho = [];

    notifyListeners();
  }
}
