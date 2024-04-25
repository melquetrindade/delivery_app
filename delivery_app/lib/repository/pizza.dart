import 'package:delivery_app/models/produto.dart';

class PizzaRepository {
  final List<Produto> _pizzas = [
    Produto(
        'Calabresa',
        'assets/pizza/calabresa.jpg',
        'Molho de tomates frescos, cebola, calabresa curada, azeitonas pretas e salpicada de orégano.',
        'Pizza',
        32.99),
    Produto(
        'Catupiry',
        'assets/pizza/catupiry.jpg',
        'Molho de tomates frescos, coberta com catupiry e salpicada de orégano.',
        'Pizza',
        32.99),
    Produto(
        'Mussarela',
        'assets/pizza/mussarela.jpg',
        'Molho de tomates frescos, mussarela e salpicada de orégano.',
        'Pizza',
        32.99),
    Produto(
        'Napolitana',
        'assets/pizza/napolitana.jpg',
        'Molho de tomates frescos, mussarela coberta com molho de tomates frescos e salpicada de parmesão e orégano..',
        'Pizza',
        32.99),
    Produto(
        'Portuguesa',
        'assets/pizza/portuguesa.jpg',
        'Molho de tomates frescos, presunto, ovos, cebola, coberta com mussarela, azeitonas pretas e orégano.',
        'Pizza',
        32.99),
  ];

  List<Produto> get pizzas => _pizzas;
}
