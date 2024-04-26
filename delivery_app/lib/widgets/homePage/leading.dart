import 'package:flutter/material.dart';

class MyLeading extends StatefulWidget {
  const MyLeading({super.key});

  @override
  State<MyLeading> createState() => _MyLeadingState();
}

class _MyLeadingState extends State<MyLeading> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 10, bottom: 5, right: 5),
      child: InkWell(
        onTap: () {
          print('click no perfil');
        },
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              border: Border.all(
                color: Colors.white,
                width: 2,
              )),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50.0),
            child: Image.asset("assets/img_perfil.png",
                height: 50.0, width: 10.0, fit: BoxFit.cover),
          ),
        ),
      ),
    );
  }
}
