import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app/databases/db_firestore.dart';
import 'package:delivery_app/models/produto.dart';
import 'package:delivery_app/services/auth_service.dart';
import 'package:flutter/material.dart';

class ItemCarrinho {
  Produto itemProduto;
  int qtd;
  String tamanho;

  double calcItemCarrinho() {
    return double.parse((itemProduto.valor * qtd).toStringAsFixed(2));
  }

  ItemCarrinho(
      {required this.itemProduto, this.qtd = 0, this.tamanho = 'null'});
}

class CarrinhoRepository extends ChangeNotifier {
  List<ItemCarrinho> _carrinho = [];
  late FirebaseFirestore db;
  late AuthService auth;
  bool loading = true;

  CarrinhoRepository({required this.auth}) {
    iniciarState();
  }

  List<ItemCarrinho> get objCarrinho => _carrinho;

  iniciarState() async {
    /*
    _dbFirebase.forEach((element) {
      _carrinho.add(element);
    });*/
    await _startFirestore();
    await _readFavoritos();
  }

  _startFirestore() {
    db = DBFirestore.get();
  }

  _readFavoritos() async {
    loading = true;
    if (auth.usuario != null && _carrinho.isEmpty) {
      final snapshot = await db
          .collection('loja/usuarios/clientes/${auth.usuario!.uid}/carrinho')
          .get();
      snapshot.docs.forEach((item) {
        _carrinho.add(ItemCarrinho(
          itemProduto: Produto(
            item['itemCarrinho']['nome'], 
            item['itemCarrinho']['img'], 
            item['itemCarrinho']['descricao'], 
            item['itemCarrinho']['categoria'], 
            item['itemCarrinho']['valor']
          ),
          qtd: item['qtd'],
          tamanho: item['tamanho']
        ));
      });

      notifyListeners();
    }
    loading = false;
  }

  addProduto(ItemCarrinho produto) async {
    List<ItemCarrinho> hasAdd = [];
    int id = 0;
    final qtd = await db
        .collection('loja/usuarios/clientes/${auth.usuario!.uid}/carrinho')
        .get();

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
        //await db.collection('loja/usuarios/clientes/${auth.usuario!.uid}/carrinho').where('itemCarrinho.nome', isEqualTo: produto.itemProduto.nome).get();
        //_dbFirebase[id].qtd = _carrinho[id].qtd;
        qtd.docs.forEach((element) {
          print(element);
        });
      } else {
        _carrinho.add(produto);
        await db
            .collection('loja/usuarios/clientes/${auth.usuario!.uid}/carrinho')
            .doc('${produto.itemProduto.nome}${produto.tamanho}')
            .set({
          'itemCarrinho': {
            'nome': produto.itemProduto.nome,
            'img': produto.itemProduto.img,
            'descricao': produto.itemProduto.descricao,
            'categoria': produto.itemProduto.categoria,
            'valor': produto.itemProduto.valor
          },
          'qtd': produto.qtd,
          'tamanho': produto.tamanho
        });
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
        //_dbFirebase[id].qtd = _carrinho[id].qtd;
      } else {
        //_dbFirebase.add(produto);
        _carrinho.add(produto);
        await db
            .collection('loja/usuarios/clientes/${auth.usuario!.uid}/carrinho')
            .doc(produto.itemProduto.nome)
            .set({
          'itemCarrinho': {
            'nome': produto.itemProduto.nome,
            'img': produto.itemProduto.img,
            'descricao': produto.itemProduto.descricao,
            'categoria': produto.itemProduto.categoria,
            'valor': produto.itemProduto.valor
          },
          'qtd': produto.qtd,
          'tamanho': produto.tamanho
        });
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
        //_dbFirebase.removeAt(id);
      } else {
        //_dbFirebase[id].qtd = _carrinho[id].qtd;
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
        //_dbFirebase.removeAt(id);
      } else {
        //_dbFirebase[id].qtd = _carrinho[id].qtd;
      }
    }

    notifyListeners();
  }

  clearCarrinho() {
    //_dbFirebase = [];
    _carrinho = [];

    notifyListeners();
  }
}


/*
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
  ];*/