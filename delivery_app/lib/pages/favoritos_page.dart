import 'package:delivery_app/models/produto.dart';
import 'package:delivery_app/repository/acai.dart';
import 'package:delivery_app/repository/bebida.dart';
import 'package:delivery_app/repository/favoritos.dart';
import 'package:delivery_app/repository/hamburguer.dart';
import 'package:delivery_app/repository/hotDog.dart';
import 'package:delivery_app/repository/milkShakers.dart';
import 'package:delivery_app/repository/pizza.dart';
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
    favoritas = context.watch<FavoritosRepository>();
    listaFavoritos = favoritas.produtosFavoritos;
    teste();
    print('no favoritos\n');

    return Scaffold(
        body: ListView.separated(
      itemBuilder: (BuildContext context, int produto) {
        return ListTile(
          title: Text(listaTeste[produto].nome),
        );
      },
      padding: EdgeInsets.all(16),
      separatorBuilder: (_, ___) => Divider(),
      itemCount: listaTeste.length,
    ));
  }
}
