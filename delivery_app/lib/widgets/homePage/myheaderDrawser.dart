import 'package:delivery_app/repository/perfil.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyHeaderDrawser extends StatefulWidget {
  final User? user;
  const MyHeaderDrawser({super.key, required this.user});

  @override
  State<MyHeaderDrawser> createState() => _MyHeaderDrawserState();
}

class _MyHeaderDrawserState extends State<MyHeaderDrawser> {
  late PerfilRepository perfil;

  @override
  Widget build(BuildContext context) {
    perfil = context.watch<PerfilRepository>();

    return Container(
      color: Colors.red,
      width: double.infinity,
      height: 190,
      padding: EdgeInsets.only(top: 50),
      child: perfil.loading
          ? Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            )
          : Column(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  height: 65,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 1),
                      image: perfil.imgProfile == ''
                          ? DecorationImage(
                              image: AssetImage("assets/app/iconeSemFoto2.jpg"))
                          : DecorationImage(
                              image: NetworkImage(perfil.imgProfile))),
                ),
                perfil.perfil.fastName == ''
                ?
                Container(
                  width: double.infinity,
                  child: Text(
                    '${widget.user!.email}',
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                )
                :
                Container(
                  width: double.infinity,
                  child: Text(
                    '${perfil.perfil.firstName} ${perfil.perfil.fastName}',
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                )
              ],
            ),
    );
  }
}
