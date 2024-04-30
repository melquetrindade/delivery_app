import 'package:delivery_app/pages/home_page.dart';
import 'package:delivery_app/repository/favoritos.dart';
import 'package:delivery_app/repository/produtos.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<ProdutosRepository>( create: (_) => ProdutosRepository()),
      ChangeNotifierProvider<FavoritosRepository>(create: (_) => FavoritosRepository()),
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
