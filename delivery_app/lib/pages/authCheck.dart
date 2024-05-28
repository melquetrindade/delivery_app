import 'package:delivery_app/pages/home_page.dart';
import 'package:delivery_app/pages/loginPage.dart';
import 'package:delivery_app/repository/carrinho.dart';
import 'package:delivery_app/repository/favoritos.dart';
import 'package:delivery_app/repository/historico.dart';
import 'package:delivery_app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthCheck extends StatefulWidget {
  const AuthCheck({super.key});

  @override
  State<AuthCheck> createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  late AuthService auth;

  @override
  Widget build(BuildContext context) {
    auth = context.watch<AuthService>();
    
    if (auth.usuario != null && context.read<FavoritosRepository>().jaCarregou) {
      print('entrou no if do auth do favoritos');
      context.read<FavoritosRepository>().setLista();
    }
    if (auth.usuario != null && context.read<CarrinhoRepository>().jaCarregou) {
      print('entrou no if do auth do carrinho');
      context.read<CarrinhoRepository>().setLista();
    }
    if (auth.usuario != null && context.read<HistoricoRepository>().jaCarregou) {
      print('entrou no if do auth do historico');
      context.read<HistoricoRepository>().setLista();
    }

    if (auth.isLoading) {
      return loading();
    } else if (auth.usuario == null) {
      return LoginPage();
    } else {
      return HomePage();
    }
  }

  loading() {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
