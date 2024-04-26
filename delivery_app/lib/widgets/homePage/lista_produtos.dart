import 'package:delivery_app/repository/hamburguer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ListaProdutos extends StatefulWidget {
  const ListaProdutos({super.key});

  @override
  State<ListaProdutos> createState() => _ListaProdutosState();
}

class _ListaProdutosState extends State<ListaProdutos> {
  //List<Produto> objs = [];
  final burger = HamburguerRepository().hamburguer;

  @override
  Widget build(BuildContext context) {
    print(burger.length);
    return Padding(
      padding: EdgeInsets.all(10),
      child: Container(
        height: 230,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [for (var i = 0; i < burger.length; i++) listaProduto(i)],
        ),
      ),
    );
  }

  Widget listaProduto(int index) {
    print(burger[index].img);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 7),
      child: InkWell(
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
                        burger[index].img,
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
                      burger[index].nome,
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
                    child: Text(burger[index].descricao, 
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 9,
                        color: Colors.grey
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
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
