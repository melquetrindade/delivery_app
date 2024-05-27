import 'package:delivery_app/models/produto.dart';
import 'package:delivery_app/pages/searchFav.dart';
import 'package:delivery_app/repository/acai.dart';
import 'package:delivery_app/repository/bebida.dart';
import 'package:delivery_app/repository/favoritos.dart';
import 'package:delivery_app/repository/hamburguer.dart';
import 'package:delivery_app/repository/hotDog.dart';
import 'package:delivery_app/repository/milkShakers.dart';
import 'package:delivery_app/repository/pizza.dart';
import 'package:delivery_app/widgets/favoritos/card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritosPage extends StatefulWidget {
  const FavoritosPage({super.key});

  @override
  State<FavoritosPage> createState() => _FavoritosPageState();
}

class _FavoritosPageState extends State<FavoritosPage> {
  late List<FavoriteProducts> listaFavoritos = [];
  late List<Produto> listaTeste = [];
  late FavoritosRepository favoritas;
  final List<Function> _funcoes = [
    () => HamburguerRepository().hamburguer,
    () => PizzaRepository().pizzas,
    () => HotDogRepository().hotdog,
    () => AcaiRepository().acai,
    () => MilkShakersRepository().milkshakers,
    () => BebidaRepository().bebida,
  ];

  teste() {
    listaTeste = [];
    _funcoes.asMap().forEach((index, element) {
      var response = _funcoes[index]();
      for (int i = 0; i < response.length; i++) {
        if (listaFavoritos.any((fav) =>
            fav.nome == response[i].nome &&
            fav.categoria == response[i].categoria)) {
          listaTeste.add(response[i]);
        }
        ;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print('renderizou');
    favoritas = context.watch<FavoritosRepository>();
    listaFavoritos = favoritas.produtosFavoritos;
    teste();

    return Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              'Favoritas',
              textAlign: TextAlign.start,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18,
                color: Colors.red,
              ),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: IconButton(
                  onPressed: () {
                    showSearch(
                        context: context,
                        delegate: SearchFavoritos(objtsProdutos: listaTeste));
                  },
                  icon: Icon(
                    Icons.search,
                    color: Colors.red,
                  )),
            )
          ],
        ),
        body: favoritas.loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : listaTeste.isEmpty
                ? ListTile(
                    leading: Icon(Icons.favorite),
                    title: Center(
                        child: Text('Ainda não há produtos favoritados')),
                  )
                : ListView.builder(
                    itemBuilder: (BuildContext context, int produto) {
                      return MyCard(produto: listaTeste[produto]);
                    },
                    padding: EdgeInsets.all(16),
                    itemCount: listaTeste.length,
                  ));
  }
}
