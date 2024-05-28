import 'package:flutter/material.dart';

class MyHeaderDrawser extends StatefulWidget {
  const MyHeaderDrawser({super.key});

  @override
  State<MyHeaderDrawser> createState() => _MyHeaderDrawserState();
}

class _MyHeaderDrawserState extends State<MyHeaderDrawser> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      width: double.infinity,
      height: 190,
      padding: EdgeInsets.only(top: 50),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 10),
            height: 65,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white,
                width: 1
              ),
              image: DecorationImage(
                image: AssetImage("assets/img_perfil.png")
              )
            ),
          ),
          Text('Melque Rodrigues', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),)
        ],
      ),
    );
  }
}
