import 'package:delivery_app/pages/home_page.dart';
import 'package:delivery_app/repository/carrinho.dart';
import 'package:delivery_app/repository/endereco.dart';
import 'package:delivery_app/repository/enderecoLoja.dart';
import 'package:delivery_app/repository/favoritos.dart';
import 'package:delivery_app/repository/historico.dart';
import 'package:delivery_app/repository/produtos.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<CarrinhoRepository>(create: (context) => CarrinhoRepository()),
      ChangeNotifierProvider<ProdutosRepository>( create: (_) => ProdutosRepository()),
      ChangeNotifierProvider<FavoritosRepository>(create: (_) => FavoritosRepository()),
      ChangeNotifierProvider<EnderecoRepository>(create: (_) => EnderecoRepository()),
      ChangeNotifierProvider<EnderecoLojaRepository>(create: (_) => EnderecoLojaRepository()),
      ChangeNotifierProvider<HistoricoRepository>(create: (_) => HistoricoRepository()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
