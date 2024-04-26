import 'package:delivery_app/models/produto.dart';
import 'package:delivery_app/repository/produtos.dart';
import 'package:delivery_app/widgets/homePage/leading.dart';
import 'package:delivery_app/widgets/homePage/lista_produtos.dart';
import 'package:delivery_app/widgets/homePage/op_produtos.dart';
import 'package:flutter/material.dart';
import 'package:delivery_app/widgets/homePage/banners.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Produto> objProdutos;
  late ProdutosRepository produtos;

  @override
  Widget build(BuildContext context) {
    produtos = context.watch<ProdutosRepository>();
    objProdutos = produtos.produto;
    print(objProdutos[0].nome);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          leading: MyLeading(),
          centerTitle: true,
          title: Text(
            'Delivery App',
            style: TextStyle(
                color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [MyBanners(), OpProdutos(produto: produtos,), ListaProdutos(objProduto: objProdutos,)],
          ),
        ));
  }
}
