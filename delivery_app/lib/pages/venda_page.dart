import 'dart:math';

import 'package:delivery_app/repository/carrinho.dart';
import 'package:delivery_app/repository/endereco.dart';
import 'package:delivery_app/repository/enderecoLoja.dart';
import 'package:delivery_app/repository/historico.dart';
import 'package:delivery_app/repository/perfil.dart';
import 'package:delivery_app/widgets/vendaPage/endereco.dart';
import 'package:delivery_app/widgets/vendaPage/formaPagamento.dart';
import 'package:delivery_app/widgets/vendaPage/revisao.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class VendaPage extends StatefulWidget {
  final List<ItemCarrinho> objItem;
  const VendaPage({super.key, required this.objItem});

  @override
  State<VendaPage> createState() => _VendaPageState();
}

class _VendaPageState extends State<VendaPage> {
  late PerfilRepository profile;
  late EnderecoLoja localizacaoLoja;
  late EnderecoLojaRepository enderecoDaLoja;
  late HistoricoRepository historicoPedidos;
  late CarrinhoRepository carrinho;
  late Endereco enderecoCliente;

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

  int gerarNumeroAleatorioDe4Digitos() {
    // Cria uma instância de Random
    Random random = Random();
    // Gera um número aleatório de 4 dígitos entre 1000 e 9999
    int numeroAleatorio = 1000 + random.nextInt(9000);

    return numeroAleatorio;
  }

  String transformarData(String data) {
    // Remove os caracteres não numéricos da string
    String dataFormatada = data.replaceAll(RegExp(r'[^0-9]'), '');
    return dataFormatada;
  }

  String gerarNumeroPedido(String data) {
    String parte01 = gerarNumeroAleatorioDe4Digitos().toString();
    String parte02 = transformarData(data);
    String numPedido = parte01 + parte02;
    return numPedido;
  }

  registerOrder() {
    if (enderecoCliente.rua != '' && profile.perfil.firstName != '') {
      DateTime now = DateTime.now();
      String formattedDateTime =
          DateFormat('dd/MM/yyyy - HH:mm:ss').format(now);
      //String formattedDateTime = '${now.day}/${now.month}/${now.year} - ${now.hour}:${now.minute}:${now.second}';
      String numeroPedido = gerarNumeroPedido(formattedDateTime);

      String typePag = '';
      if (selectedOption == 1) {
        typePag = 'Em Espécie';
      } else if (selectedOption == 2) {
        typePag = 'Pix';
      } else {
        typePag = 'Cartão';
      }

      historicoPedidos.registerHistoric(
          Historico(
              carrinho: widget.objItem,
              cliente: '${profile.perfil.firstName} ${profile.perfil.fastName}',
              data: formattedDateTime,
              formaPag: typePag,
              frete: isDelivery ? 0 : localizacaoLoja.frete),
          numeroPedido);

      carrinho.clearCarrinho();

      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Seu pedido foi enviado com sucesso!'),
          duration: Duration(seconds: 30),
          action: SnackBarAction(label: 'OK', onPressed: () {}),
        ),
      );

      sendWhatsAppMessage('+5584999687569', mountMenssage(numeroPedido));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Você precisa ter um endereço de entrega e um perfil pra poder realizar o pedido!'),
          duration: Duration(seconds: 30),
          action: SnackBarAction(label: 'OK', onPressed: () {}),
        ),
      );
    }
  }

  void sendWhatsAppMessage(String phoneNumber, String message) async {
    final String url =
        'https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}';

    // ignore: deprecated_member_use
    if (await canLaunch(url)) {
      print('entrou no if');
      // ignore: deprecated_member_use
      await launch(url);
    } else {
      print('entrou else');
      throw 'Could not launch $url';
    }
  }

  funcSetEndereco(Endereco newEnd) {
    enderecoCliente = newEnd;
  }

  String mountMenssage(String numPedido) {
    String message = 'Boa Noite, gostaria de fazer o pedido:\n\n';
    List<String> produtos = [];

    String typePag = '';
    if (selectedOption == 1) {
      typePag = 'Em Espécie';
    } else if (selectedOption == 2) {
      typePag = 'Pix';
    } else {
      typePag = 'Cartão';
    }

    widget.objItem.forEach((item) {
      if (item.itemProduto.categoria == 'Pizza') {
        produtos.add(
            '${item.itemProduto.nome} (${item.tamanho}) --- qtd: ${item.qtd}');
      } else {
        produtos.add('${item.itemProduto.nome} --- qtd: ${item.qtd}');
      }
    });
    message = message + 'Nº do Pedido: ${numPedido}\n\n';
    message = message + produtos.join('\n');
    if (isDelivery == false) {
      message = message +
          '\n\nEndereço de Entrega: \nRua: ${enderecoCliente.rua} - Nº ${enderecoCliente.num}\nBairro: ${enderecoCliente.bairro} - Complemento: ${enderecoCliente.complemento}\nPonto de Referência: ${enderecoCliente.referencia}\n\nForma de Pagamento: ${typePag}';
    } else {
      message = message +
          '\n\nVou querer retirar o pedido no estabelecimento\n\nForma de Pagamento: ${typePag}';
    }

    return message;
  }

  @override
  Widget build(BuildContext context) {
    profile = context.read<PerfilRepository>();
    carrinho = context.read<CarrinhoRepository>();
    historicoPedidos = context.read<HistoricoRepository>();
    enderecoDaLoja = context.watch<EnderecoLojaRepository>();
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
              endCliente: funcSetEndereco,
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
                  onPressed: () => registerOrder(),
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


/*
  Future<void> launchWhatsApp(String phoneNumber, String message) async {
    String url = 'https://wa.me/$phoneNumber?text=${Uri.encodeFull(message)}';

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Não foi possível lançar $url';
    }
  }*/