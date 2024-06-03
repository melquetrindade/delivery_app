import 'package:delivery_app/pages/uploadFoto.dart';
import 'package:delivery_app/repository/perfil.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PerfilPage extends StatefulWidget {
  const PerfilPage({super.key});

  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  late Perfil profile;
  late PerfilRepository perfilRepository;
  final formKey = GlobalKey<FormState>();
  final nome = TextEditingController();
  final sobreNome = TextEditingController();
  final telefone = TextEditingController();

  setForm() {
    setState(() {
      nome.text = profile.firstName;
      sobreNome.text = profile.fastName;
      telefone.text = profile.numberPhone;
    });
  }

  @override
  Widget build(BuildContext context) {
    perfilRepository = context.watch<PerfilRepository>();
    profile = perfilRepository.perfil;

    if (!perfilRepository.loading) {
      setForm();
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.red),
        centerTitle: true,
        title: Text(
          'Editar Perfil',
          style: TextStyle(
              color: Colors.red, fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ),
      body: perfilRepository.loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 20, left: 12, right: 12, bottom: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 18),
                      height: 85,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.black, width: 1),
                          image: perfilRepository.imgProfile == ''
                              ? DecorationImage(
                                  image: AssetImage(
                                      "assets/app/iconeSemFoto2.jpg"))
                              : DecorationImage(
                                  image: NetworkImage(
                                      perfilRepository.imgProfile))),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => UploadFotoPage(),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            border: Border.all(color: Colors.black, width: 1),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 5, bottom: 5, left: 10, right: 10),
                            child: Text(
                              'Alterar Foto',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13,
                                  color: Colors.red),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset:
                                Offset(1, 2), // mudança de posição da sombra
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: Form(
                            key: formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextFormField(
                                          controller: nome,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText: 'Nome',
                                            labelStyle: TextStyle(fontSize: 14),
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    vertical: 10,
                                                    horizontal: 12),
                                          ),
                                          keyboardType: TextInputType.text,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Informe o seu nome!';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextFormField(
                                          controller: sobreNome,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText: 'Sobrenome',
                                            labelStyle: TextStyle(fontSize: 14),
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    vertical: 10,
                                                    horizontal: 12),
                                          ),
                                          keyboardType: TextInputType.text,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Informe o seu sobrenome!';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextFormField(
                                          controller: telefone,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText: 'Telefone',
                                            labelStyle: TextStyle(fontSize: 14),
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    vertical: 10,
                                                    horizontal: 12),
                                          ),
                                          onChanged: (value) {
                                            
                                            String formattedValue = value.replaceAll(RegExp(r'\D'), '');
                                            print(value.length);
                                            if (value.length <= 11) {
                                              

                                              if (formattedValue.length == 11) {
                                                formattedValue =
                                                    '(${formattedValue.substring(0, 2)}) ${formattedValue.substring(2, 11)}';
                                              }
                                              telefone.text = formattedValue;
                                            } else {
                                              telefone.text = value;
                                            }
                                          },
                                          keyboardType: TextInputType.text,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Informe o seu telefone!';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30, bottom: 20),
                      child: Container(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.red),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                                side: BorderSide.none,
                              ),
                            ),
                          ),
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              print('salvar no firestore');
                              /*
                                Navigator.pop(context);
                
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          'Endereço adicionado com sucesso!')),
                                );*/
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(top: 15, bottom: 15),
                            child: Text(
                              'Salvar',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

/*
actions: [
          IconButton(
              onPressed: () {
                print('chamar a função de upload');
                perfil.pickerAndUploadImage();
              },
              icon: Icon(Icons.upload))
        ],
 */