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

  @override
  Widget build(BuildContext context) {
    historico = context.watch<HistoricoRepository>();
    pedidos = historico.historico;

    pedidos.forEach((item) {
      print(item.data);
    });

    return Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          backgroundColor: Colors.white,
          //iconTheme: IconThemeData(color: Colors.red),
          centerTitle: true,
          title: const Text(
            'Meus Pedidos',
            style: TextStyle(
                color: Colors.red, fontSize: 18, fontWeight: FontWeight.w500),
          ),
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
            title: Text('${item.cliente}',
                style: TextStyle(fontSize: 15),
                maxLines: 1,
                overflow: TextOverflow.ellipsis
            ),
            subtitle: Text(
              '${item.data}',
              style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 13),
            ),
            trailing: Text('R\$ ${valorTotal}', style: TextStyle(fontSize: 14),)),
      ));
      widgets.add(Divider());
    }
    return Column(
      children: widgets,
    );
  }
}
