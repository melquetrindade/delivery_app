import 'package:delivery_app/models/produto.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class ProdutoDetails extends StatefulWidget {
  final Produto produto;
  const ProdutoDetails({super.key, required this.produto});

  @override
  State<ProdutoDetails> createState() => _ProdutoDetailsState();
}

class _ProdutoDetailsState extends State<ProdutoDetails> {
  ScrollController _scrollController = ScrollController();

 @override
 void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection == ScrollDirection.reverse) {
        print("SliverAppBar arrastado para cima");
      }
    });
 }
  @override
  Widget build(BuildContext context) {
    print(widget.produto.nome);
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                 bottomLeft: Radius.circular(30),
                 bottomRight: Radius.circular(30),
                ),
            ),
            iconTheme: IconThemeData(color: Colors.white),
            backgroundColor: Colors.red,
            expandedHeight: 260,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Padding(
                padding: const EdgeInsets.all(60.0),
                child: Image.asset(widget.produto.img,
                fit: BoxFit.fill,
                ),
              ),
              title: Text(widget.produto.nome),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                height: 100,
                color: Colors.blue,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                height: 100,
                color: Colors.blue,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                height: 100,
                color: Colors.blue,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                height: 100,
                color: Colors.blue,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                height: 100,
                color: Colors.blue,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                height: 100,
                color: Colors.blue,
              ),
            ),
          ),
        ],
      )
    );
  }

  @override
  void dispose() {
      _scrollController.dispose();
      super.dispose();
  }
}
