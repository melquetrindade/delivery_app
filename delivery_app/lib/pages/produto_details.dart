import 'package:delivery_app/models/produto.dart';
import 'package:delivery_app/widgets/produtosDetails/components_body.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class ProdutoDetails extends StatefulWidget {
  final Produto produto;
  const ProdutoDetails({super.key, required this.produto});

  @override
  State<ProdutoDetails> createState() => _ProdutoDetailsState();
}

class _ProdutoDetailsState extends State<ProdutoDetails> {
  late double valorProduto;

  @override
  Widget build(BuildContext context) {
    //print(widget.produto.nome);
    valorProduto = widget.produto.valor;
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverAppBar(
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Colors.red,
          expandedHeight: 290,
          floating: false,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            background: Padding(
              padding: const EdgeInsets.all(60.0),
              child: Image.asset(
                widget.produto.img,
                fit: BoxFit.fill,
              ),
            ),
            title: Padding(
              padding: const EdgeInsets.symmetric(vertical: 13),
              child: Text(
                widget.produto.nome,
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
              ),
            ),
            centerTitle: true,
            titlePadding: EdgeInsets.symmetric(horizontal: 10),
          ),
        ),
        MyComponents(
          objProduto: widget.produto,
        ),
      ],
    ));
  }
}
