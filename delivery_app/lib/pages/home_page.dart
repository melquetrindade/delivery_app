import 'package:delivery_app/pages/carrinho_page.dart';
import 'package:delivery_app/pages/favoritos_page.dart';
import 'package:delivery_app/pages/info_pages.dart';
import 'package:delivery_app/pages/menu_page.dart';
import 'package:delivery_app/pages/pedidos_page.dart';
import 'package:delivery_app/repository/carrinho.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late int qtdCarrinho;
  late CarrinhoRepository carrinho;
  int paginaAtual = 0;
  late PageController pc;

  @override
  void initState() {
    super.initState();
    pc = PageController(initialPage: paginaAtual);
  }

  setPaginaAtual(pagina) {
    setState(() {
      paginaAtual = pagina;
    });
  }

  @override
  Widget build(BuildContext context) {
    print('no home');
    carrinho = context.watch<CarrinhoRepository>();
    qtdCarrinho = carrinho.objCarrinho.length;

    return Scaffold(
      body: PageView(
        controller: pc,
        children: [
          Menu(),
          FavoritosPage(),
          CarrinhoPage(),
          PedidosPage(),
          InfoPage(),
        ],
        onPageChanged: setPaginaAtual,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: paginaAtual,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Menu'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favoritos'),
          BottomNavigationBarItem(
              icon: Badge(
                  label: Text(
                    qtdCarrinho > 0 ? '$qtdCarrinho' : '0',
                  ),
                  child: Icon(Icons.local_grocery_store_outlined)),
              label: 'Carrinho'),
          BottomNavigationBarItem(
              icon: Icon(Icons.playlist_add_check), label: 'Pedidos'),
          BottomNavigationBarItem(
              icon: Icon(Icons.info_outline), label: 'Info'),
        ],
        onTap: (pagina) {
          pc.animateToPage(
            pagina,
            duration: Duration(milliseconds: 400),
            curve: Curves.ease,
          );
        },
      ),
    );
  }
}
