import 'package:delivery_app/models/produto.dart';

class MilkShakersRepository {
  final List<Produto> _milkshakers = [
    Produto(
        'Milk Shake Kopenhagen',
        'assets/milkshakers/shakeKopenhagen.png',
        'Deliciosamente cremoso. O novo McShake Chocolate Kopenhagen é feito com leite e batido na hora. Uma delícia!',
        'MilkShakers',
        10.99),
    Produto(
        'Milk Shake Morango',
        'assets/milkshakers/shakeMorango.png',
        'Deliciosamente cremoso. O novo McShake Morango é feito com leite e batido na hora. Uma delícia!',
        'MilkShakers',
        10.99),
    Produto(
        'Milk Shake Ovomaltine',
        'assets/milkshakers/shakeOvomaltine.png',
        'Deliciosamente cremoso. O novo McShake Ovomaltine é feito com leite e batido na hora. Uma delícia!',
        'MilkShakers',
        10.99)
  ];

  List<Produto> get milkshakers => _milkshakers;
}
