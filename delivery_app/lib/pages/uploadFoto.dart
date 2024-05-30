import 'package:delivery_app/repository/perfil.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UploadFotoPage extends StatefulWidget {
  const UploadFotoPage({super.key});

  @override
  State<UploadFotoPage> createState() => _UploadFotoPageState();
}

class _UploadFotoPageState extends State<UploadFotoPage> {
  late PerfilRepository perfil;
  bool uploading = false;
  double total = 0;

  @override
  Widget build(BuildContext context) {
    perfil = context.watch<PerfilRepository>();
    uploading = perfil.uploading;
    total = perfil.total;
    print('renderizou a pag de upload');

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.red),
        centerTitle: true,
        title: uploading
            ? Text('${total.round()}% enviados',style: TextStyle(
                color: Colors.red,
                fontSize: 18,
                fontWeight: FontWeight.w500),)
            : Text(
                'Alterar foto de perfil',
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              ),
        actions: [
          uploading
              ? Padding(
                  padding: EdgeInsets.only(right: 12),
                  child: Center(
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 3,
                        color: Colors.red,
                      ),
                    ),
                  ),
                )
              : IconButton(
                  onPressed: () {
                    print('chamar a função de upload');
                    perfil.pickerAndUploadImage();
                  },
                  icon: Icon(Icons.upload))
        ],
      ),
      body: Container(),
    );
  }
}
