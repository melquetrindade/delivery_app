import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RevisaoPage extends StatefulWidget {
  final int qtdTotal;
  final double subTotal;
  final bool isDelivery;
  final double frete;
  final double valorTotal;
  const RevisaoPage(
      {super.key,
      required this.qtdTotal,
      required this.subTotal,
      required this.isDelivery,
      required this.frete,
      required this.valorTotal});

  @override
  State<RevisaoPage> createState() => _RevisaoPageState();
}

class _RevisaoPageState extends State<RevisaoPage> {
  String subTotalFormat = '';
  String freteFormat = '';
  String valorTotalFormat = '';

  formatValues() {
    subTotalFormat = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$')
        .format(widget.subTotal);
    freteFormat = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$')
        .format(widget.frete);
    valorTotalFormat = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$')
        .format(widget.valorTotal);
  }

  @override
  Widget build(BuildContext context) {
    formatValues();

    return Container(
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
                Text('Produtos (${widget.qtdTotal})'),
                Text('${subTotalFormat}')
              ],
            ),
            widget.isDelivery == false
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text('Frete'), Text('${freteFormat}')],
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
                  '${valorTotalFormat}',
                  style: TextStyle(fontWeight: FontWeight.w600),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
