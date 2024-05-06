import 'package:delivery_app/models/produto.dart';
import 'package:delivery_app/repository/carrinho.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CarrinhoPage extends StatefulWidget {
  const CarrinhoPage({super.key});

  @override
  State<CarrinhoPage> createState() => _CarrinhoPageState();
}

class _CarrinhoPageState extends State<CarrinhoPage> {
  late List<Produto> listaCarrinho;
  late CarrinhoRepository carrinho;

  addAoCarrinho(Produto produto) {
    carrinho.addProduto(produto);
  }

  @override
  Widget build(BuildContext context) {
    print('mudou o carrinho pages');
    carrinho = context.watch<CarrinhoRepository>();
    listaCarrinho = carrinho.objCarrinho;
    listaCarrinho.forEach((element) => print(element.nome));

    return Scaffold(
      body: Column(
        children: [
          Center(
            child: Text('Carrinho'),
          ),
          /*
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
                      borderRadius: BorderRadius.circular(8), // Raio dos cantos
                      side: BorderSide.none, // Remove a borda
                    ),
                  ),
                ),
                onPressed: () {
                  addPro();
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
          )*/
        ],
      ),
    );
  }
}
