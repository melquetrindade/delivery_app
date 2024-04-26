import 'package:delivery_app/widgets/homePage/leading.dart';
import 'package:delivery_app/widgets/homePage/lista_produtos.dart';
import 'package:delivery_app/widgets/homePage/op_produtos.dart';
import 'package:flutter/material.dart';
import 'package:delivery_app/widgets/homePage/banners.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: MyLeading(),
        centerTitle: true,
        title: Text(
          'Delivery App',
          style: TextStyle(color: Colors.black, fontSize: 14),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            MyBanners(),
            OpProdutos(),
            ListaProdutos()
          ],
        ),
      )
    );
  }
}
