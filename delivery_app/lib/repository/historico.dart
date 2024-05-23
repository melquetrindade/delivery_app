import 'package:delivery_app/models/produto.dart';
import 'package:delivery_app/repository/carrinho.dart';
import 'package:flutter/cupertino.dart';

class Historico {
  List<ItemCarrinho> carrinho;
  String cliente;
  String data;
  String formaPag;
  double frete;

  double calcTotalCarrinho() {
    double valorParcial = 0;
    carrinho.forEach((element) {
      valorParcial += element.calcItemCarrinho();
    });
    return double.parse(valorParcial.toStringAsFixed(2));
  }

  Historico(
      {required this.carrinho,
      required this.cliente,
      required this.data,
      required this.formaPag,
      required this.frete});
}

class HistoricoRepository extends ChangeNotifier {
  List<Historico> _historico = [];
  List<Historico> _dbFirebase = [
    Historico(
        carrinho: [
          ItemCarrinho(
              itemProduto: Produto(
                  'McNífico Bacon',
                  'assets/hamburguer/mcNificoBacon.png',
                  'Um hambúrguer (carne 100% bovina), bacon, alface americana, cebola, queijo processado sabor cheddar, tomate, maionese, ketchup, mostarda e pão com gergelim.',
                  'Hambúrguer',
                  13.99),
              qtd: 2,
              tamanho: 'null'),
          ItemCarrinho(
              itemProduto: Produto(
                  'Coca-Cola Lata',
                  'assets/bebidas/coca_lata.jpg',
                  'Desfrute do clássico sabor refrescante da Coca-Cola em uma lata conveniente de 330ml.',
                  'Bebida',
                  4.00),
              qtd: 2,
              tamanho: 'null'),
          ItemCarrinho(
              itemProduto: Produto(
                  'Calabresa',
                  'assets/pizza/calabresa.jpg',
                  'Molho de tomates frescos, cebola, calabresa curada, azeitonas pretas e salpicada de orégano.',
                  'Pizza',
                  32.99),
              qtd: 1,
              tamanho: 'P')
        ],
        cliente: 'Melque Rodrigues da Trindade Santos da Costa Oliveira ',
        data: '16/05/2024 - 14:08:45',
        formaPag: 'Pix',
        frete: 5.00),
    Historico(
        carrinho: [
          ItemCarrinho(
              itemProduto: Produto(
                  'Big Mac',
                  'assets/hamburguer/bigMac.png',
                  'Dois hambúrgueres (100% carne bovina), alface americana, queijo processado sabor cheddar, molho especial, cebola, picles e pão com gergelim.',
                  'Hambúrguer',
                  16.99),
              qtd: 1,
              tamanho: 'null'),
          ItemCarrinho(
              itemProduto: Produto(
                  'Coca-Cola Lata',
                  'assets/bebidas/coca_lata.jpg',
                  'Desfrute do clássico sabor refrescante da Coca-Cola em uma lata conveniente de 330ml.',
                  'Bebida',
                  4.00),
              qtd: 2,
              tamanho: 'null'),
          ItemCarrinho(
              itemProduto: Produto(
                  'Catupiry',
                  'assets/pizza/catupiry.jpg',
                  'Molho de tomates frescos, coberta com catupiry e salpicada de orégano.',
                  'Pizza',
                  32.99),
              qtd: 1,
              tamanho: 'G')
        ],
        cliente: 'Melque Rodrigues',
        data: '16/05/2024 - 14:08:59',
        formaPag: 'Em Espécie',
        frete: 5.00),
    Historico(
        carrinho: [
          ItemCarrinho(
              itemProduto: Produto(
                  'Duplo Quarterão',
                  'assets/hamburguer/duploQuarterao.png',
                  'Dois hambúrgueres (carne 100% bovina), mostarda, ketchup, cebola, queijo processado sabor cheddar e pão com gergelim.',
                  'Hambúrguer',
                  16.99),
              qtd: 3,
              tamanho: 'null'),
          ItemCarrinho(
              itemProduto: Produto(
                  'Guaraná Lata',
                  'assets/bebidas/guarana_lata.jpg',
                  'Experimente a energia natural do guaraná em uma lata prática de 330ml, perfeita para acompanhar suas refeições.',
                  'Bebida',
                  3.50),
              qtd: 2,
              tamanho: 'null'),
          ItemCarrinho(
              itemProduto: Produto(
                  'Calabresa',
                  'assets/pizza/calabresa.jpg',
                  'Molho de tomates frescos, cebola, calabresa curada, azeitonas pretas e salpicada de orégano.',
                  'Pizza',
                  32.99),
              qtd: 1,
              tamanho: 'M')
        ],
        cliente: 'Melque Rodrigues',
        data: '13/05/2024 - 20:19:45',
        formaPag: 'Pix',
        frete: 5.00),
    Historico(
        carrinho: [
          ItemCarrinho(
              itemProduto: Produto(
                  'Dog Simples',
                  'assets/hotDog/dogSimples.jpg',
                  'pão, salsicha, carne moída, molho especial e batata palha',
                  'HotDog',
                  4.50),
              qtd: 4,
              tamanho: 'null'),
          ItemCarrinho(
              itemProduto: Produto(
                  'Açaí Tradicional',
                  'assets/acai/acai.jpg',
                  'Açaí, leite condensado, leite em pó, granola e banana - 250ml',
                  'Açaí',
                  12.99),
              qtd: 2,
              tamanho: 'null'),
          ItemCarrinho(
              itemProduto: Produto(
                  'Milk Shake Kopenhagen',
                  'assets/milkshakers/shakeKopenhagen.png',
                  'Deliciosamente cremoso. O novo McShake Chocolate Kopenhagen é feito com leite e batido na hora. Uma delícia!',
                  'MilkShakers',
                  10.99),
              qtd: 1,
              tamanho: 'null')
        ],
        cliente: 'Melque Rodrigues',
        data: '02/04/2024 - 20:38:45',
        formaPag: 'Cartão',
        frete: 5.00)
  ];

  HistoricoRepository() {
    iniciarState();
  }

  List<Historico> get historico => _historico;

  iniciarState() {
    _historico = _dbFirebase;
  }

  registerHistoric(Historico pedido) {
    _dbFirebase = [];
    _historico.add(pedido);
    _dbFirebase = _historico;
  }
}
