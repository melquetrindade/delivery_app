import 'package:delivery_app/models/produto.dart';
import 'package:delivery_app/widgets/favoritos/card.dart';
import 'package:flutter/material.dart';

class SearchFavoritos extends SearchDelegate {
  final List<Produto> objtsProdutos;

  SearchFavoritos({required this.objtsProdutos});

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
      appBarTheme: const AppBarTheme(
        color: Colors.red,
      ),
      textTheme: const TextTheme(
        titleLarge: TextStyle(fontSize: 15.0, color: Colors.white),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        fillColor: Colors.red,
        filled: true,
        hintStyle: TextStyle(fontSize: 15.0, color: Colors.white),
      ),
    );
  }

  @override
  String get searchFieldLabel => "nome do produto";

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(
          Icons.clear,
          color: Colors.white,
        ),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.arrow_back,
        color: Colors.white,
      ),
      onPressed: () {
        close(context, "");
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text("Resultados para: $query", style: TextStyle(color: Colors.black),);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List matchQuery = [];
    for (var item in objtsProdutos) {
      if (item.nome.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(item);
      }
    }

    return ListView.separated(
      itemBuilder: (BuildContext context, int produto) {
        return MyCard(produto: matchQuery[produto]);
      },
      padding: EdgeInsets.all(16),
      separatorBuilder: (_, ___) => Divider(),
      itemCount: matchQuery.length,
    );
  }
}
