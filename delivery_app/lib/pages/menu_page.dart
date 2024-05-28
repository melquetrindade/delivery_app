import 'package:delivery_app/models/produto.dart';
import 'package:delivery_app/repository/produtos.dart';
import 'package:delivery_app/services/auth_service.dart';
//import 'package:delivery_app/widgets/homePage/leading.dart';
import 'package:delivery_app/widgets/homePage/lista_produtos.dart';
import 'package:delivery_app/widgets/homePage/myheaderDrawser.dart';
import 'package:delivery_app/widgets/homePage/op_produtos.dart';
import 'package:flutter/material.dart';
import 'package:delivery_app/widgets/homePage/banners.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  late List<Produto> objProdutos;
  late ProdutosRepository produtos;
  late AuthService authService;

  @override
  Widget build(BuildContext context) {
    authService = context.read<AuthService>();
    produtos = context.watch<ProdutosRepository>();
    objProdutos = produtos.produto;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          centerTitle: true,
          title: Text(
            'Delivery App',
            style: TextStyle(
                color: Colors.white, fontSize: 17, fontWeight: FontWeight.w500),
          ),
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: Icon(Icons.menu),
                color: Colors.white,
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            },
          ),
        ),
        drawer: Drawer(
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [MyHeaderDrawser(), myDrawserList()],
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              MyBanners(),
              OpProdutos(
                produto: produtos,
              ),
              ListaProdutos(
                objProduto: objProdutos,
              )
            ],
          ),
        ));
  }

  Widget myDrawserList() {
    return Container(
      padding: EdgeInsets.all(15),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              print('abrir configurações de perfil');
            },
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  Expanded(
                      child: Icon(
                    Icons.person_outline_outlined,
                    size: 23,
                    color: Colors.black,
                  )),
                  Expanded(
                      flex: 3,
                      child: Text(
                        'Perfil',
                        style: TextStyle(
                            color: Colors.grey[800],
                            fontSize: 17,
                            fontWeight: FontWeight.w400),
                      ))
                ],
              ),
            ),
          ),
          Divider(),
          InkWell(
            onTap: () {
              print('abrir configurações de endereço');
            },
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  Expanded(
                      child: Icon(
                    Icons.location_on_outlined,
                    size: 23,
                    color: Colors.black,
                  )),
                  Expanded(
                      flex: 3,
                      child: Text(
                        'Endereço',
                        style: TextStyle(
                            color: Colors.grey[800],
                            fontSize: 17,
                            fontWeight: FontWeight.w400),
                      ))
                ],
              ),
            ),
          ),
          Divider(),
          InkWell(
            onTap: () {
              authService.logout();
            },
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  Expanded(
                      child: Icon(
                    Icons.logout,
                    size: 23,
                    color: Colors.red,
                  )),
                  Expanded(
                      flex: 3,
                      child: Text(
                        'Sair',
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 17,
                            fontWeight: FontWeight.w600),
                      ))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
