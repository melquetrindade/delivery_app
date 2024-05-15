import 'package:delivery_app/repository/carrinho.dart';
import 'package:delivery_app/widgets/vendaPage/endereco.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class VendaPage extends StatefulWidget {
  final List<ItemCarrinho> objItem;
  const VendaPage({super.key, required this.objItem});

  @override
  State<VendaPage> createState() => _VendaPageState();
}

class _VendaPageState extends State<VendaPage> {
  int qtdTotal = 0;
  double subTotal = 0;
  bool isDelivery = false;
  double frete = 5;
  double valorTotal = 0;

  calcQuantidade() {
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
    if (isDelivery) {
      double total = 0;
      total = subTotal + frete;
      valorTotal = double.parse(total.toStringAsFixed(2));
    } else {
      valorTotal = subTotal;
    }
  }

  @override
  Widget build(BuildContext context) {
    calcQuantidade();
    calcPreco();
    calcValorTotal();
    frete = double.parse(frete.toStringAsFixed(2));

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.red),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Endereço',
          style: TextStyle(
              color: Colors.red, fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey.shade600,
                    width: 1,
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Produtos ($qtdTotal)'),
                        Text('R\$ ${subTotal}')
                      ],
                    ),
                    isDelivery
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [Text('Frete'), Text('R\$ ${frete}')],
                          )
                        : Container(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        Text(
                          'R\$ ${valorTotal}',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            ComponenteEndereco(),
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