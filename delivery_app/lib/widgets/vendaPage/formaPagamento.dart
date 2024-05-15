import 'package:flutter/material.dart';

class FormaPagamento extends StatefulWidget {
  final int selectedOption;
  final bool isDelivery;
  final Function uptadeState;
  const FormaPagamento(
      {super.key,
      required this.selectedOption,
      required this.isDelivery,
      required this.uptadeState});

  @override
  State<FormaPagamento> createState() => _FormaPagamentoState();
}

class _FormaPagamentoState extends State<FormaPagamento> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 0, left: 12, right: 12, bottom: 12),
      child: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 9),
              child: Container(
                width: double.infinity,
                child: Text(
                  'Forma de Pagamento',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                  textAlign: TextAlign.start,
                ),
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
                        groupValue: widget.selectedOption,
                        activeColor: Colors.blue,
                        fillColor: MaterialStateProperty.all(Colors.blue),
                        splashRadius: 20,
                        onChanged: (value) {
                          widget.uptadeState(value);
                        }),
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.pix),
                    title: Text('Pix'),
                    trailing: Radio(
                        value: 2,
                        groupValue: widget.selectedOption,
                        activeColor: Colors.blue,
                        fillColor: MaterialStateProperty.all(Colors.blue),
                        splashRadius: 20,
                        onChanged: (value) {
                          widget.uptadeState(value);
                        }),
                  ),
                  Divider(),
                  widget.isDelivery == false
                      ? ListTile(
                          leading: Icon(Icons.credit_card),
                          title: Text('Cartão'),
                          trailing: Radio(
                              value: 3,
                              groupValue: widget.selectedOption,
                              activeColor: Colors.blue,
                              fillColor: MaterialStateProperty.all(Colors.blue),
                              splashRadius: 20,
                              onChanged: (value) {
                                widget.uptadeState(value);
                              }),
                        )
                      : Container(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
