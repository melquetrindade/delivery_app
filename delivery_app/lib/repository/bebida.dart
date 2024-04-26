import 'package:delivery_app/models/produto.dart';

class BebidaRepository {
  final List<Produto> _bebidas = [
    Produto(
        'Coca-Cola Lata',
        'assets/bebidas/coca_lata.jpg',
        'Desfrute do clássico sabor refrescante da Coca-Cola em uma lata conveniente de 330ml.',
        'Hambúrguer',
        4.00),
    Produto(
        'Guaraná Lata',
        'assets/bebidas/guarana_lata.jpg',
        'Experimente a energia natural do guaraná em uma lata prática de 330ml, perfeita para acompanhar suas refeições.',
        'Hambúrguer',
        3.50),
    Produto(
        'Coca-Cola 1L',
        'assets/bebidas/coca_1litro.jpg',
        'Satisfaça sua sede com a icônica Coca-Cola, agora em uma generosa garrafa de 1 litro.',
        'Hambúrguer',
        8.00),
    Produto(
        'Guaraná 1L',
        'assets/bebidas/guarana_1litro.jpg',
        'Aproveite o sabor vibrante do guaraná em uma garrafa de 1 litro, para momentos de compartilhamento e prazer.',
        'Hambúrguer',
        7.50),
    Produto(
        'Fanta Laranja Lata',
        'assets/bebidas/fanta_lata.jpg',
        'Refresque-se com a deliciosa Fanta Laranja em uma lata compacta de 330ml, cheia de sabor cítrico e diversão.',
        'Hambúrguer',
        3.00),
  ];

  List<Produto> get bebida => _bebidas;
}
