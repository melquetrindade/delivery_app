import 'package:delivery_app/pages/home_page.dart';
import 'package:delivery_app/repository/carrinho.dart';
import 'package:delivery_app/repository/enderecoLoja.dart';
import 'package:delivery_app/repository/historico.dart';
import 'package:delivery_app/widgets/vendaPage/endereco.dart';
import 'package:delivery_app/widgets/vendaPage/formaPagamento.dart';
import 'package:delivery_app/widgets/vendaPage/revisao.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
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
  late HistoricoRepository historicoPedidos;
  late CarrinhoRepository carrinho;

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
      if (selectedOption == 3) {
        selectedOption = 1;
      }
    });
  }

  setCheck(int value) {
    setState(() {
      selectedOption = value;
    });
  }

  registerOrder() {
    DateTime now = DateTime.now();
    String formattedDateTime = DateFormat('dd/MM/yyyy - HH:mm:ss').format(now);
    //String formattedDateTime = '${now.day}/${now.month}/${now.year} - ${now.hour}:${now.minute}:${now.second}';

    String typePag = '';
    if (selectedOption == 1) {
      typePag = 'Em Espécie';
    } else if (selectedOption == 2) {
      typePag = 'Pix';
    } else {
      typePag = 'Cartão';
    }

    historicoPedidos.registerHistoric(Historico(
        carrinho: widget.objItem,
        cliente: 'Melque Rodrigues',
        data: formattedDateTime,
        formaPag: typePag,
        frete: localizacaoLoja.frete));

    carrinho.clearCarrinho();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => HomePage(),
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Seu pedido foi enviado com sucesso!'),
        duration: Duration(seconds: 30),
        action: SnackBarAction(label: 'OK', onPressed: () {}),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    carrinho = context.read<CarrinhoRepository>();
    historicoPedidos = context.read<HistoricoRepository>();
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
                valorTotal: valorTotal),
            ComponenteEndereco(
              isCheck: isDelivery,
              toggleState: togglerDelivery,
              localizacaoLoja: localizacaoLoja,
            ),
            FormaPagamento(
              selectedOption: selectedOption,
              isDelivery: isDelivery,
              uptadeState: setCheck,
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 12, right: 12, top: 20, bottom: 30),
              child: Container(
                width: double.infinity,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.red),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero, // Raio dos cantos
                        side: BorderSide.none, // Remove a borda
                      ),
                    ),
                  ),
                  onPressed: () {
                    registerOrder();
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15, bottom: 15),
                    child: Text(
                      'Realizar Pedido',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
