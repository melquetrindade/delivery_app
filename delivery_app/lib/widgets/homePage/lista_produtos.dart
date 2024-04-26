import 'package:delivery_app/models/produto.dart';
import 'package:delivery_app/repository/hamburguer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ListaProdutos extends StatefulWidget {
  final List<Produto> objProduto;
  const ListaProdutos({super.key, required this.objProduto});

  @override
  State<ListaProdutos> createState() => _ListaProdutosState();
}

class _ListaProdutosState extends State<ListaProdutos> {
  //List<Produto> objs = [];
  //final burger = HamburguerRepository().hamburguer;

  @override
  Widget build(BuildContext context) {
    print(widget.objProduto.length);
    return Padding(
      padding: EdgeInsets.all(10),
      child: Container(
        height: 230,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [for (var i = 0; i < widget.objProduto.length; i++) listaProduto(i)],
        ),
      ),
    );
  }

  Widget listaProduto(int index) {
    double preco = widget.objProduto[index].valor;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 7),
      child: InkWell(
        onTap: () {
          print('clicou no details');
        },
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: Offset(1, 2), // mudança de posição da sombra
                ),
              ],
            ),
            width: 152,
            child: Column(
              children: [
                Center(
                  child: SizedBox(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Image.asset(
                        widget.objProduto[index].img,
                        fit: BoxFit.fill,
                      ),
                    ),
                    width: 100,
                    height: 85,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: FittedBox(
                    child: Text(
                      widget.objProduto[index].nome,
                      textAlign: TextAlign.start,
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                    fit: BoxFit.scaleDown,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Container(
                    height: 45,
                    child: Text(
                      widget.objProduto[index].descricao,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 9,
                          color: Colors.grey),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Container(
                    height: 35,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'R\$ $preco',
                          style: TextStyle(
                              fontWeight: FontWeight.w800, color: Colors.red),
                        ),
                        Transform.translate(
                          offset: Offset(0, -10),
                          child: IconButton(
                            icon: Icon(
                              Icons.add_circle,
                              color: Colors.red,
                              size: 40,
                            ),
                            onPressed: () {
                              print('add ao carrinho');
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
