import 'package:delivery_app/pages/authCheck.dart';
import 'package:delivery_app/repository/carrinho.dart';
import 'package:delivery_app/repository/endereco.dart';
import 'package:delivery_app/repository/enderecoLoja.dart';
import 'package:delivery_app/repository/favoritos.dart';
import 'package:delivery_app/repository/historico.dart';
import 'package:delivery_app/repository/produtos.dart';
import 'package:delivery_app/services/auth_service.dart';
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
      ChangeNotifierProvider<AuthService>(create: (context) => AuthService()),
      ChangeNotifierProvider<CarrinhoRepository>(create: (context) => CarrinhoRepository(auth: context.read<AuthService>())),
      ChangeNotifierProvider<ProdutosRepository>( create: (context) => ProdutosRepository()),
      ChangeNotifierProvider<FavoritosRepository>(create: (context) => FavoritosRepository(auth: context.read<AuthService>())),
      ChangeNotifierProvider<EnderecoRepository>(create: (context) => EnderecoRepository()),
      ChangeNotifierProvider<EnderecoLojaRepository>(create: (context) => EnderecoLojaRepository()),
      ChangeNotifierProvider<HistoricoRepository>(create: (context) => HistoricoRepository()),
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
      home: const AuthCheck(),
    );
  }
}
