import 'package:delivery_app/models/produto.dart';

class HotDogRepository {
  final List<Produto> _hotDogs = [
    Produto(
        'Dog Simples',
        'assets/hotDog/dogSimples.jpg',
        'pão, salsicha, carne moída, molho especial e batata palha',
        'HotDog',
        4.50),
    Produto(
        'Dog Top',
        'assets/hotDog/dogTop.jpg',
        'pão 20cm, 2 salsichas, carne moída, frango desfiado, bacon em cubos crocante, calabresa, cebola e molho especial',
        'HotDog',
        8.00),
    Produto(
        'Dog Chicken',
        'assets/hotDog/dogChicken.jpg',
        'pão, salsicha de frango, frango desfiado, catupiry e batata palha',
        'HotDog',
        5.00),
    Produto(
        'Dog Extra',
        'assets/hotDog/dogExtra.jpg',
        'pão, salsicha, carne moída, catupiry, cebola, calabresa e batata palha',
        'HotDog',
        5.00),
    Produto(
        'Dog Mania',
        'assets/hotDog/dogMania.jpg',
        'pão, salsicha, frango desfiado, cheddar, bacon em cubos crocante e batata palha',
        'HotDog',
        5.00),
  ];

  List<Produto> get hotdog => _hotDogs;
}
