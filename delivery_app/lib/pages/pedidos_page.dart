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
  
  String _selectedOption = 'option1';

  @override
  Widget build(BuildContext context) {
    historico = context.watch<HistoricoRepository>();
    pedidos = historico.historico;

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
                    Icons.search,
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

  loadWrap(Function funcSet) {
    return Container(
      color: Colors.grey[50],
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Wrap(
          children: [
            Container(
                height: 50,
                width: double.infinity,
                child: Text(
                  'Filtrar Por:',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[700]),
                )),
            Container(
                width: double.infinity,
                child: ListTile(
                  title: Text('Op 1'),
                  trailing: Radio(
                      value: 1,
                      groupValue: selectedOption,
                      activeColor: Colors.blue,
                      fillColor: MaterialStateProperty.all(Colors.blue),
                      splashRadius: 20,
                      onChanged: (value) {
                        funcSet(value);
                      }),
                )),
            Divider(),
            Container(
                width: double.infinity,
                child: ListTile(
                  title: Text('Op 2'),
                  trailing: Radio(
                      value: 2,
                      groupValue: selectedOption,
                      activeColor: Colors.blue,
                      fillColor: MaterialStateProperty.all(Colors.blue),
                      splashRadius: 20,
                      onChanged: (value) {
                        print('opa 2');
                        funcSet(value);
                      }),
                )),
            Divider(),
            Container(
                width: double.infinity,
                child: ListTile(
                  title: Text('Op 3'),
                  trailing: Radio(
                      value: 3,
                      groupValue: selectedOption,
                      activeColor: Colors.blue,
                      fillColor: MaterialStateProperty.all(Colors.blue),
                      splashRadius: 20,
                      onChanged: (value) {
                        print('opa 3');
                        funcSet(value);
                      }),
                )),
            Divider(),
            Container(
                width: double.infinity,
                child: ListTile(
                  title: Text('Op 4'),
                  trailing: Radio(
                      value: 4,
                      groupValue: selectedOption,
                      activeColor: Colors.blue,
                      fillColor: MaterialStateProperty.all(Colors.blue),
                      splashRadius: 20,
                      onChanged: (value) {
                        print('opa 4');
                        funcSet(value);
                      }),
                )),
          ],
        ),
      ),
    );
  }

  void _showBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        // Utiliza StatefulBuilder para gerenciar o estado localmente no BottomSheet
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  RadioListTile<String>(
                    title: Text('Option 1'),
                    value: 'option1',
                    groupValue: _selectedOption,
                    onChanged: (String? value) {
                      // Atualiza o estado local no BottomSheet
                      setState(() {
                        _selectedOption = value!;
                      });
                    },
                  ),
                  RadioListTile<String>(
                    title: Text('Option 2'),
                    value: 'option2',
                    groupValue: _selectedOption,
                    onChanged: (String? value) {
                      // Atualiza o estado local no BottomSheet
                      setState(() {
                        _selectedOption = value!;
                      });
                    },
                  ),
                  ElevatedButton(
                    child: Text('Confirm'),
                    onPressed: () {
                      Navigator.pop(context, _selectedOption);
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    ).then((selectedValue) {
      if (selectedValue != null) {
        setState(() {
          _selectedOption = selectedValue;
        });
      }
    });
  }
}
