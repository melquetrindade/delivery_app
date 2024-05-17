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
        color: Colors.white,
      ),
      textTheme: const TextTheme(
        titleLarge: TextStyle(fontSize: 15.0, color: Colors.black),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        fillColor: Colors.white,
        filled: true,
        hintStyle: TextStyle(fontSize: 15.0, color: Colors.grey),
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
          color: Colors.red,
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
        color: Colors.red,
      ),
      onPressed: () {
        close(context, "");
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List matchQuery = [];
    for (var item in objtsProdutos) {
      if (item.nome.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(item);
      }
    }

    if (matchQuery.isEmpty) {
      return Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off),
            Text(
              "Sem Resultados para: $query",
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
      );
    }
    return ListView.builder(
      itemBuilder: (BuildContext context, int produto) {
        return MyCard(produto: matchQuery[produto]);
      },
      padding: EdgeInsets.all(16),
      itemCount: matchQuery.length,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List matchQuery = [];
    for (var item in objtsProdutos) {
      if (item.nome.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(item);
      }
    }

    return ListView.builder(
      itemBuilder: (BuildContext context, int produto) {
        return MyCard(produto: matchQuery[produto]);
      },
      padding: EdgeInsets.all(16),
      itemCount: matchQuery.length,
    );
  }
}
