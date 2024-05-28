import 'package:delivery_app/databases/db_firestore.dart';
import 'package:delivery_app/models/produto.dart';
import 'package:delivery_app/services/auth_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FavoriteProducts {
  final String nome;
  final String categoria;

  FavoriteProducts(this.nome, this.categoria);
}

class FavoritosRepository extends ChangeNotifier {
  List<FavoriteProducts> _produtosFavoritos = [];
  late FirebaseFirestore db;
  late AuthService auth;
  bool loading = true;

  List<FavoriteProducts> get produtosFavoritos => _produtosFavoritos;

  FavoritosRepository({required this.auth}) {
    print('carregou o construtor');
    iniciarState();
  }

  iniciarState() async {
    await _startFirestore();
    await _readFavoritos();
  }

  _startFirestore() {
    db = DBFirestore.get();
  }

  _readFavoritos() async {
    loading = true;
    if (auth.usuario != null) {
      print('entrou para carregar uid: ${auth.usuario!.uid}');
      final snapshot = await db
          .collection('loja/usuarios/clientes/${auth.usuario!.uid}/favoritas')
          .get();
      snapshot.docs.forEach((item) {
        print('no read favoritos: ${item}');
        _produtosFavoritos
            .add(FavoriteProducts(item.get('produto'), item.get('categoria')));
      });

      notifyListeners();
    }
    loading = false;
  }

  saveProduto(Produto produto) async {
    _produtosFavoritos.add(FavoriteProducts(produto.nome, produto.categoria));
    await db
        .collection('loja/usuarios/clientes/${auth.usuario!.uid}/favoritas')
        .doc(produto.nome)
        .set({'produto': produto.nome, 'categoria': produto.categoria});

    notifyListeners();
  }

  removeProduto(Produto produto) async {
    _produtosFavoritos.removeWhere((item) => item.nome == produto.nome);
    await db
        .collection('loja/usuarios/clientes/${auth.usuario!.uid}/favoritas')
        .doc(produto.nome)
        .delete();

    notifyListeners();
  }
}
