import 'package:delivery_app/models/produto.dart';
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

  /*
  ScrollController _scrollController = ScrollController();
  bool _isAtTop = false; 
  bool hasScroll = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.offset <= _scrollController.position.minScrollExtent && _isAtTop) {
        toggleAppBar(true);
        print("SliverAppBar arrastado para baixo");
        _isAtTop = false;
      } else if(_scrollController.offset > _scrollController.position.minScrollExtent && _isAtTop == false) {
        toggleAppBar(false);
        _isAtTop = true;
        print("SliverAppBar arrastado para cima");
      }
    });
  }

  toggleAppBar(bool state) {
    setState(() {
      hasScroll = state;
    });
  }*/

  @override
  Widget build(BuildContext context) {
    print(widget.produto.nome);
    valorProduto = widget.produto.valor;
    return Scaffold(
        body: CustomScrollView(
      //controller: _scrollController,
      slivers: [
        SliverAppBar(
          /*
          shape: (hasScroll == true)
              ? RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                )
              : null,*/
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Colors.red[400],
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
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              child: Column(
                children: [
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
                          child: Text('R\$ $valorProduto',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                              color: Colors.red
                            ),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.pink[50],
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: IconButton(
                          onPressed: () {
                            print('clicou para favoritar');
                          },
                          icon: Icon(Icons.favorite_border_outlined), iconSize: 30, color: Colors.black,),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(widget.produto.descricao,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        height: 1.5
                      ),
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
                            backgroundColor: MaterialStateProperty.all<Color>(Colors.red.shade400), // Cor de fundo
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8), // Raio dos cantos
                                side: BorderSide.none, // Remove a borda
                              ),
                            ),
                          ),
                        onPressed: () {
                            // Respond to button press
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 15, bottom: 15),
                          child: Text('Adicionar ao Carrinho', style: TextStyle(color: Colors.white, fontSize: 15),),
                        ),
                      ),
                    ),
                  )
                ]
              ),
            ),
          ),
        ),
      ],
    ));
  }

  /*
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }*/
}
