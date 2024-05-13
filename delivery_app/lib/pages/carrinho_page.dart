import 'package:delivery_app/repository/carrinho.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class CarrinhoPage extends StatefulWidget {
  const CarrinhoPage({super.key});

  @override
  State<CarrinhoPage> createState() => _CarrinhoPageState();
}

class _CarrinhoPageState extends State<CarrinhoPage> {
  late List<ItemCarrinho> listaCarrinho;
  late CarrinhoRepository carrinho;

  @override
  Widget build(BuildContext context) {
    carrinho = context.watch<CarrinhoRepository>();
    listaCarrinho = carrinho.objCarrinho;
    //listaCarrinho.forEach((element) => print(element.itemProduto.nome));

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.red,
        centerTitle: true,
        title: Text(
          'Carrinho',
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(6),
          child: listaCarrinho.isEmpty
              ? ListTile(
                  leading: Icon(Icons.favorite),
                  title: Text('Ainda não há produtos favoritos'),
                )
              : Column(children: [
                  loadCarrinho(),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 12, right: 12, top: 30),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.red.shade400), // Cor de fundo
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(8), // Raio dos cantos
                                side: BorderSide.none, // Remove a borda
                              ),
                            ),
                          ),
                          onPressed: () {},
                          child: Padding(
                            padding: const EdgeInsets.only(top: 15, bottom: 15),
                            child: Text(
                              'Continuar',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ]),
        ),
      ),
    );
  }

  loadCarrinho() {
    List<Widget> widgets = [];
    int qtdProduto = 0;
    String nome = '';
    String tam = '';
    for (var item in listaCarrinho) {
      qtdProduto = item.qtd;
      nome = item.itemProduto.nome;
      tam = item.tamanho;

      widgets.add(Container(
        margin: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          leading: SizedBox(
              width: 50,
              child: Image.asset(item.itemProduto.img, fit: BoxFit.fill)),
          title: Text(item.itemProduto.categoria == 'Pizza' ? '$nome ($tam)' : '$nome',
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12)),
          subtitle: Text(
            'R\$ ${item.itemProduto.valor}',
            style: TextStyle(
                fontWeight: FontWeight.w600, color: Colors.red, fontSize: 12),
          ),
          trailing: Container(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.remove_circle,
                    color: Colors.red,
                    size: 25,
                  ),
                ),
                Container(
                    child: Center(
                        child: Text(
                  '$qtdProduto',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                ))),
                IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.add_circle, color: Colors.red, size: 25))
              ],
            ),
          ),
        ),
      ));
    }
    return Column(
      children: widgets,
    );
  }
}
