import 'package:delivery_app/models/produto.dart';
import 'package:delivery_app/repository/favoritos.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyComponents extends StatefulWidget {
  final Produto objProduto;
  const MyComponents({super.key, required this.objProduto});

  @override
  State<MyComponents> createState() => _MyComponentsState();
}

class _MyComponentsState extends State<MyComponents> {
  late FavoritosRepository favoritas;

  favoritarProduto() {
    favoritas.saveProduto(widget.objProduto);
  }

  desfavoritarProduto() {
    favoritas.removeProduto(widget.objProduto);
  }

  @override
  Widget build(BuildContext context) {
    favoritas = context.watch<FavoritosRepository>();
    favoritas.produtosFavoritos.forEach((element) => {
      print(element.nome)
    });
    
    double valorProduto = widget.objProduto.valor;

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.pink[50],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      'R\$ $valorProduto',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          color: Colors.red),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.pink[50],
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: (favoritas.produtosFavoritos
                          .any((fav) => fav.nome == widget.objProduto.nome))
                      ? IconButton(
                          onPressed: () {
                            desfavoritarProduto();
                          },
                          icon: Icon(Icons.favorite),
                          iconSize: 30,
                          color: Colors.red,
                        )
                      : IconButton(
                          onPressed: () {
                            favoritarProduto();
                          },
                          icon: Icon(Icons.favorite_outline),
                          iconSize: 30,
                          color: Colors.black,
                        ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                widget.objProduto.descricao,
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: 15, fontWeight: FontWeight.w500, height: 1.5),
                maxLines: 6,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 120),
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Colors.red.shade400), // Cor de fundo
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(8), // Raio dos cantos
                        side: BorderSide.none, // Remove a borda
                      ),
                    ),
                  ),
                  onPressed: () {
                    // Respond to button press
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15, bottom: 15),
                    child: Text(
                      'Adicionar ao Carrinho',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
