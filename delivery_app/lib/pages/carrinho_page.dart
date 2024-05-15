import 'package:delivery_app/pages/venda_page.dart';
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

  navVendaPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => VendaPage(
          objItem: listaCarrinho,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    carrinho = context.watch<CarrinhoRepository>();
    listaCarrinho = carrinho.objCarrinho;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Carrinho',
          style: TextStyle(
              color: Colors.red, fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ),
      body: listaCarrinho.isEmpty
          ? ListTile(
              leading: Icon(Icons.local_grocery_store),
              title: Center(child: Text('Ainda não há produtos no carrinho!')),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(6),
                child: Column(children: [
                  loadCarrinho(),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 12, right: 12, top: 30),
                    child: Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.red), // Cor de fundo
                          shape: MaterialStateProperty.all<
                              RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.zero, // Raio dos cantos
                              side: BorderSide.none, // Remove a borda
                            ),
                          ),
                        ),
                        onPressed: () {
                          navVendaPage();
                        },
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
                ]),
              ),
            ),
    );
  }

  loadCarrinho() {
    List<Widget> widgets = [];

    for (var item in listaCarrinho) {
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
          title: Text(
              item.itemProduto.categoria == 'Pizza'
                  ? '${item.itemProduto.nome} (${item.tamanho})'
                  : '${item.itemProduto.nome}',
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
                  onPressed: () {
                    carrinho.deleteProduto(item);
                  },
                  icon: Icon(
                    Icons.remove_circle,
                    color: Colors.red,
                    size: 25,
                  ),
                ),
                Container(
                    child: Center(
                        child: Text(
                  '${item.qtd}',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                ))),
                IconButton(
                    onPressed: () {
                      int qtdTotal = 0;
                      carrinho.objCarrinho.forEach((element) {
                        qtdTotal += element.qtd;
                      });
                      if (qtdTotal <= 9) {
                        carrinho.addProduto(item);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                'A Política do restaurante permite a quantidade máxima de até 10 unidades de produtos por pedido!'),
                            duration: Duration(seconds: 60),
                            action: SnackBarAction(
                                label: 'OK',
                                onPressed: () {
                                  //Navigator.pop(context);
                                }),
                          ),
                        );
                      }
                    },
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