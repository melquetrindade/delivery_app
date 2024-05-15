import 'package:delivery_app/repository/carrinho.dart';
import 'package:delivery_app/repository/enderecoLoja.dart';
import 'package:delivery_app/widgets/vendaPage/endereco.dart';
import 'package:delivery_app/widgets/vendaPage/revisao.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class VendaPage extends StatefulWidget {
  final List<ItemCarrinho> objItem;
  const VendaPage({super.key, required this.objItem});

  @override
  State<VendaPage> createState() => _VendaPageState();
}

class _VendaPageState extends State<VendaPage> {
  late EnderecoLoja localizacaoLoja;
  late EnderecoLojaRepository enderecoDaLoja;
  int qtdTotal = 0;
  double subTotal = 0;
  bool isDelivery = false;
  double valorTotal = 0;
  int selectedOption = 1;

  calcQuantidade() {
    qtdTotal = 0;
    widget.objItem.forEach((item) {
      qtdTotal += item.qtd;
    });
  }

  calcPreco() {
    double valor = 0;
    widget.objItem.forEach((item) {
      valor += item.itemProduto.valor * item.qtd;
    });
    subTotal = double.parse(valor.toStringAsFixed(2));
  }

  calcValorTotal() {
    if (isDelivery == false) {
      double total = 0;
      total = subTotal + localizacaoLoja.frete;
      valorTotal = double.parse(total.toStringAsFixed(2));
    } else {
      valorTotal = subTotal;
    }
  }

  togglerDelivery(bool value) {
    setState(() {
      isDelivery = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    enderecoDaLoja = context.read<EnderecoLojaRepository>();
    localizacaoLoja = enderecoDaLoja.enderecoLoja;
    calcQuantidade();
    calcPreco();
    calcValorTotal();

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.red),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Revisão',
          style: TextStyle(
              color: Colors.red, fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            RevisaoPage(
              qtdTotal: qtdTotal, 
              subTotal: subTotal, 
              isDelivery: isDelivery, 
              frete: localizacaoLoja.frete, 
              valorTotal: valorTotal
            ),
            ComponenteEndereco(
              isCheck: isDelivery,
              toggleState: togglerDelivery,
              localizacaoLoja: localizacaoLoja,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 0, left: 12, right: 12, bottom: 12),
              child: Container(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 9),
                      child: Container(
                        width: double.infinity,
                        child: Text('Forma de Pagamento', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400), textAlign: TextAlign.start,),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: Offset(1, 2), // mudança de posição da sombra
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          ListTile(
                            leading: Icon(Icons.money_rounded),
                            title: Text('Em Espécie'),
                            trailing: Radio(
                              value: 1,
                              groupValue: selectedOption,
                              activeColor: Colors.red,
                              fillColor: MaterialStateProperty.all(Colors.red),
                              splashRadius: 20,
                              onChanged: (value) {
                                setState(() {
                                  selectedOption = value!;
                                });
                            }),
                          ),
                          Divider(),
                          ListTile(
                            leading: Icon(Icons.pix),
                            title: Text('Pix'),
                            trailing: Radio(
                              value: 2,
                              groupValue: selectedOption,
                              activeColor: Colors.red,
                              fillColor: MaterialStateProperty.all(Colors.red),
                              splashRadius: 20,
                              onChanged: (value) {
                                setState(() {
                                  selectedOption = value!;
                                });
                            }),
                          ),
                          Divider(),
                          isDelivery == false
                          ?
                          ListTile(
                            leading: Icon(Icons.credit_card),
                            title: Text('Cartão'),
                            trailing: Radio(
                              value: 3,
                              groupValue: selectedOption,
                              activeColor: Colors.red,
                              fillColor: MaterialStateProperty.all(Colors.red),
                              splashRadius: 20,
                              onChanged: (value) {
                                setState(() {
                                  selectedOption = value!;
                                });
                            }),
                          )
                          : Container(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}


/*
Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: Offset(2, 0), // mudança de posição da sombra
                ),
              ],
            ),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Icon(
                        Icons.motorcycle_rounded,
                        color: Colors.red,
                      ),
                      Text(
                        'Entrega',
                        style: TextStyle(
                            fontSize: 11,
                            color: Colors.red,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Icon(
                        Icons.credit_card,
                        color: Colors.black,
                      ),
                      Text('Pagamento',
                          style: TextStyle(
                              fontSize: 11,
                              color: Colors.black,
                              fontWeight: FontWeight.w500))
                    ],
                  ),
                  Column(
                    children: [
                      Icon(
                        Icons.list_alt,
                        color: Colors.black,
                      ),
                      Text('Revisão',
                          style: TextStyle(
                              fontSize: 11,
                              color: Colors.black,
                              fontWeight: FontWeight.w500))
                    ],
                  ),
                ],
              ),
            ),
          ),
*/