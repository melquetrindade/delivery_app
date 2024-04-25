import 'package:flutter/material.dart';

class Produtos {
  final String nome;
  final String img;

  Produtos(this.nome, this.img);
}

class OpProdutos extends StatefulWidget {
  const OpProdutos({super.key});

  @override
  State<OpProdutos> createState() => _OpProdutosState();
}

class _OpProdutosState extends State<OpProdutos> {
  List<Produtos> produtos = [
    Produtos('Hambúrguer', 'assets/icon_hamburguer.png'),
    Produtos('Pizza', 'assets/icon_hamburguer.png'),
    Produtos('Hot-Dog', 'assets/icon_hamburguer.png'),
    Produtos('Açaí', 'assets/icon_hamburguer.png'),
    Produtos('Milkshakers', 'assets/icon_hamburguer.png'),
    Produtos('Bebidas', 'assets/icon_hamburguer.png'),
  ];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15),
      child: Container(
        height: 55,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            for (var i = 0; i < produtos.length; i++)
              buildIndicator(currentIndex == i, i)
          ],
        ),
      ),
    );
  }

  Widget buildIndicator(bool isSelected, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: InkWell(
        onTap: () {
          setState(() {
            currentIndex = index;
          });
        },
        child: Container(
          decoration: BoxDecoration(
              color: isSelected ? Colors.red : Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.red,
                width: 1,
              )),
          height: 40,
          width: 145,
          child: ListTile(
            leading: SizedBox(
              child: Image.asset(produtos[index].img),
              width: 25,
            ),
            title: FittedBox(
              child: Text(
                produtos[index].nome,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 14
                  ),
              ),
              fit: BoxFit.scaleDown,
            ),
          ),
        ),
      ),
    );
  }
}
