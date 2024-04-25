import 'package:delivery_app/models/produto.dart';

class AcaiRepository {
  final List<Produto> _acais = [
    Produto(
        'Açaí Tradicional',
        'assets/acai/acai.jpg',
        'Açaí, leite condensado, leite em pó, granola e banana - 250ml',
        'Açaí',
        12.99),
    Produto(
        'Açaí Mix',
        'assets/acai/acai.jpg',
        'Açaí, leite condensado, leite em pó, granola, amendoim e M&Ms - 275ml',
        'Açaí',
        13.99),
    Produto(
        'Açaí Maltine',
        'assets/acai/acai.jpg',
        'Açaí, leite condensado, leite em pó, granola, amendoim, ovomaltine e banana - 300ml',
        'Açaí',
        14.99),
    Produto(
        'Big Açaí',
        'assets/acai/acai.jpg',
        'Açaí, leite condensado, leite em pó, granola, amendoim, M&M, canudinho walffer, morango - 350ml',
        'Açaí',
        15.99)
  ];

  List<Produto> get acai => _acais;
}
