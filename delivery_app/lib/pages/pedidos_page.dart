import 'package:delivery_app/pages/historicoDetails.dart';
import 'package:delivery_app/repository/carrinho.dart';
import 'package:delivery_app/repository/historico.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PedidosPage extends StatefulWidget {
  const PedidosPage({super.key});

  @override
  State<PedidosPage> createState() => _PedidosPageState();
}

class _PedidosPageState extends State<PedidosPage> {
  late List<Historico> pedidos;
  late HistoricoRepository historico;
  int selectedOption = 1;

  orderLast() {
    print('menos recente');
    pedidos.sort((a, b) => a.data.compareTo(b.data));
  }

  orderFirst() {
    print('mais recente');
    pedidos.sort((a, b) => b.data.compareTo(a.data));
  }

  orderLowerValue() {
    print('menor valor');
    pedidos
        .sort((a, b) => a.calcTotalCarrinho().compareTo(b.calcTotalCarrinho()));
  }

  orderHighestValue() {
    print('maior valor');
    pedidos
        .sort((a, b) => b.calcTotalCarrinho().compareTo(a.calcTotalCarrinho()));
  }

  navVendaPage(Historico pedidoHist) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => HistoricoDetails(
          pedido: pedidoHist,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    historico = context.watch<HistoricoRepository>();
    pedidos = historico.historico;

    if (selectedOption == 1) {
      orderFirst();
    } else if (selectedOption == 2) {
      orderLast();
    } else if (selectedOption == 3) {
      orderHighestValue();
    } else {
      orderLowerValue();
    }

    return Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: const Text(
            'Meus Pedidos',
            style: TextStyle(
                color: Colors.red, fontSize: 18, fontWeight: FontWeight.w500),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: IconButton(
                  onPressed: () {
                    _showBottomSheet();
                  },
                  icon: Icon(
                    Icons.filter_list,
                    color: Colors.red,
                  )),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: loadHistorico(),
          ),
        ));
  }

  loadHistorico() {
    List<Widget> widgets = [];
    double valorTotal = 0;

    calcTotal(List<ItemCarrinho> carrinho) {
      double subTotal = 0;
      valorTotal = 0;

      carrinho.forEach((itemCar) {
        subTotal += itemCar.qtd * itemCar.itemProduto.valor;
        valorTotal = double.parse(subTotal.toStringAsFixed(2));
      });
    }

    for (var item in pedidos) {
      calcTotal(item.carrinho);

      widgets.add(Container(
        child: ListTile(
            onTap: () {
              navVendaPage(item);
            },
            title: Text('${item.cliente}',
                style: TextStyle(fontSize: 15),
                maxLines: 1,
                overflow: TextOverflow.ellipsis),
            subtitle: Text(
              '${item.data}',
              style: TextStyle(color: Colors.grey[600], fontSize: 13),
            ),
            trailing: Text(
              'R\$ ${valorTotal}',
              style: TextStyle(fontSize: 14),
            )),
      ));
      widgets.add(Divider());
    }
    return Column(
      children: widgets,
    );
  }

  void _showBottomSheet() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // Utiliza StatefulBuilder para gerenciar o estado localmente no BottomSheet
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: Center(child: Text("Filtrar Por:")),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  RadioListTile<int>(
                    title: Text('Mais Recente'),
                    value: 1,
                    groupValue: selectedOption,
                    onChanged: (int? value) {
                      setState(() {
                        selectedOption = value!;
                      });
                    },
                  ),
                  RadioListTile<int>(
                    title: Text('Menos Recente'),
                    value: 2,
                    groupValue: selectedOption,
                    onChanged: (int? value) {
                      setState(() {
                        selectedOption = value!;
                      });
                    },
                  ),
                  RadioListTile<int>(
                    title: Text('Maior Valor'),
                    value: 3,
                    groupValue: selectedOption,
                    onChanged: (int? value) {
                      setState(() {
                        selectedOption = value!;
                      });
                    },
                  ),
                  RadioListTile<int>(
                    title: Text('Menor Valor'),
                    value: 4,
                    groupValue: selectedOption,
                    onChanged: (int? value) {
                      setState(() {
                        selectedOption = value!;
                      });
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          child: Text('Fechar'),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                                side: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          child: Text('Aplicar'),
                          onPressed: () {
                            Navigator.pop(context, selectedOption);
                          },
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                                side: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            );
          },
        );
      },
    ).then((selectedValue) {
      if (selectedValue != null) {
        setState(() {
          selectedOption = selectedValue;
        });
      }
    });
  }
}
