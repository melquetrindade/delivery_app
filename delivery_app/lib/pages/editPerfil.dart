import 'package:flutter/material.dart';

class PerfilPage extends StatefulWidget {
  const PerfilPage({super.key});

  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.red),
        centerTitle: true,
        title: Text(
          'Upload',
          style: TextStyle(
              color: Colors.red, fontSize: 18, fontWeight: FontWeight.w500),
        ),
        actions: [
          IconButton(
              onPressed: () {
                print('chamar a função de upload');
              },
              icon: Icon(Icons.upload))
        ],
      ),
    );
  }
}
