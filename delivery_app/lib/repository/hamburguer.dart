import 'package:delivery_app/models/produto.dart';

class HamburguerRepository {
  final List<Produto> _hamburguer = [
    Produto(
        'McNífico Bacon',
        'assets/hamburguer/mcNificoBacon.png',
        'Um hambúrguer (carne 100% bovina), bacon, alface americana, cebola, queijo processado sabor cheddar, tomate, maionese, ketchup, mostarda e pão com gergelim.',
        'Hambúrguer',
        13.99),
    Produto(
        'Big Mac',
        'assets/hamburguer/bigMac.png',
        'Dois hambúrgueres (100% carne bovina), alface americana, queijo processado sabor cheddar, molho especial, cebola, picles e pão com gergelim.',
        'Hambúrguer',
        16.99),
    Produto(
        'Duplo Quarterão',
        'assets/hamburguer/duploQuarterao.png',
        'Dois hambúrgueres (carne 100% bovina), mostarda, ketchup, cebola, queijo processado sabor cheddar e pão com gergelim.',
        'Hambúrguer',
        16.99),
    Produto(
        'Quarterão com Queijo',
        'assets/hamburguer/quarteraoComQueijo.png',
        'Um hambúrguer (100% carne bovina), queijo processado sabor cheddar, picles, cebola, ketchup, mostarda e pão com gergelim.',
        'Hambúrguer',
        13.99),
    Produto(
        'Duplo Burger Bacon',
        'assets/hamburguer/duploBurgerBacon.png',
        'Dois hambúrgueres (carne 100% bovina), queijo processado sabor cheddar, cebola, fatias de bacon, ketchup, mostarda e pão com gergelim.',
        'Hambúrguer',
        15.99),
  ];

  List<Produto> get hamburguer => _hamburguer;
}
