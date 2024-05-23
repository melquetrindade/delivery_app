import 'package:delivery_app/repository/historico.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HistoricoDetails extends StatefulWidget {
  final Historico pedido;
  const HistoricoDetails({super.key, required this.pedido});

  @override
  State<HistoricoDetails> createState() => _HistoricoDetailsState();
}

class _HistoricoDetailsState extends State<HistoricoDetails> {
  //double valorTotal = 0;
  String valorTotalFormat = '';

  @override
  Widget build(BuildContext context) {
    //double valorTotal = widget.pedido.calcTotalCarrinho();
    valorTotalFormat = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$').format(widget.pedido.calcTotalCarrinho());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.red),
        centerTitle: true,
        title: Text(
          'Detalhes do Pedido',
          style: TextStyle(
              color: Colors.red, fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey[50],
                    border: Border.all(
                      color: Colors.grey.shade400,
                      width: 1,
                    )),
                child: Column(
                  children: [
                    ListTile(
                      visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                      title: Text('Cliente:',
                          style: TextStyle(fontSize: 12, color: Colors.black),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis),
                      subtitle: Text('${widget.pedido.cliente}',
                          style:
                              TextStyle(fontSize: 11, color: Colors.grey[600]),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis),
                    ),
                    Divider(
                      color: Colors.grey[400],
                      height: 0,
                    ),
                    ListTile(
                      visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                      title: Text('Data:',
                          style: TextStyle(fontSize: 12, color: Colors.black),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis),
                      subtitle: Text('${widget.pedido.data}',
                          style:
                              TextStyle(fontSize: 11, color: Colors.grey[600]),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis),
                    ),
                    Divider(
                      color: Colors.grey[400],
                      height: 0,
                    ),
                    ListTile(
                      visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                      title: Text('Forma de Pagamento:',
                          style: TextStyle(fontSize: 12, color: Colors.black),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis),
                      subtitle: Text('${widget.pedido.formaPag}',
                          style:
                              TextStyle(fontSize: 11, color: Colors.grey[600]),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis),
                    ),
                    Divider(
                      color: Colors.grey[400],
                      height: 0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Container(
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 7),
                            child: Text(
                              'CARRINHO:',
                              style: TextStyle(fontSize: 12),
                            ),
                          )),
                    ),
                    loadToken(),
                    ListTile(
                      title: Text(
                        'TOTAL:',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 15),
                      ),
                      trailing: Text('${valorTotalFormat}',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 15)),
                    )
                  ],
                )),
          ),
        ),
      ),
    );
  }

  loadToken() {
    List<Widget> widgets = [];
    String subTotalFormat = '';
    String valorUnitario = '';

    for (var item in widget.pedido.carrinho) {
      subTotalFormat = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$')
          .format(item.calcItemCarrinho());
      valorUnitario = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$')
          .format(item.itemProduto.valor);

      widgets.add(ListTile(
          visualDensity: VisualDensity(horizontal: 0, vertical: -4),
          title: Text(
              item.itemProduto.categoria == 'Pizza'
                  ? '${item.itemProduto.nome} (${item.tamanho})'
                  : '${item.itemProduto.nome}',
              style: TextStyle(fontSize: 12),
              maxLines: 1,
              overflow: TextOverflow.ellipsis),
          subtitle: Text(
            'Qtd: ${item.qtd}',
            style: TextStyle(color: Colors.grey[600], fontSize: 11),
          ),
          trailing: Padding(
            padding: const EdgeInsets.only(top: 3),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Valor Unitário: ${valorUnitario}',
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.w300),
                ),
                Text(
                  'SubTotal: ${subTotalFormat}',
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.w400),
                ),
              ],
            ),
          )));
      widgets.add(Divider(
        color: Colors.grey[400],
        height: 0,
      ));
    }

    return Column(
      children: widgets,
    );
  }
}
