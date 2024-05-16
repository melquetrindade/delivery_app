import 'package:delivery_app/repository/endereco.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class EditEndereco extends StatefulWidget {
  const EditEndereco({super.key});

  @override
  State<EditEndereco> createState() => _EditEnderecoState();
}

class _EditEnderecoState extends State<EditEndereco> {
  final formKey = GlobalKey<FormState>();
  final rua = TextEditingController();
  final bairro = TextEditingController();
  final num = TextEditingController();
  final complemento = TextEditingController();
  final referencia = TextEditingController();

  late Endereco enderecoCliente;
  late EnderecoRepository endereco;

  setEndereco() {
    setState(() {
      rua.text = enderecoCliente.rua;
      bairro.text = enderecoCliente.bairro;
      num.text = enderecoCliente.num;
      complemento.text = enderecoCliente.complemento;
      referencia.text = enderecoCliente.referencia;
    });
  }

  @override
  Widget build(BuildContext context) {
    endereco = context.watch<EnderecoRepository>();
    enderecoCliente = endereco.endereco;

    setEndereco();

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.red),
        centerTitle: true,
        title: const Text(
          'Atualize seu Endereço',
          style: TextStyle(
              color: Colors.red, fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 40, left: 12, right: 12, bottom: 20),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: Offset(1, 2), // mudança de posição da sombra
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
                                flex: 3,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    controller: rua,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Rua',
                                      labelStyle: TextStyle(fontSize: 14),
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 12),
                                    ),
                                    keyboardType: TextInputType.text,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Informe o nome da Rua corretamente!';
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
                                    controller: num,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Nº',
                                      labelStyle: TextStyle(fontSize: 14),
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 12),
                                    ),
                                    keyboardType: TextInputType.text,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Informe o número da residência corretamente!';
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
                                    controller: bairro,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Bairro',
                                      labelStyle: TextStyle(fontSize: 14),
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 12),
                                    ),
                                    keyboardType: TextInputType.text,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Informe o nome do Bairro corretamente!';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    controller: complemento,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Complemento',
                                      labelStyle: TextStyle(fontSize: 14),
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 12),
                                    ),
                                    keyboardType: TextInputType.text,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Informe o complemento corretamente!';
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
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    controller: referencia,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Refêrencia',
                                      labelStyle: TextStyle(fontSize: 14),
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 12),
                                    ),
                                    keyboardType: TextInputType.text,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Informe a Refêrencia corretamente!';
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
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero, // Raio dos cantos
                          side: BorderSide.none, // Remove a borda
                        ),
                      ),
                    ),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        endereco.updateEndereco(Endereco(
                            rua: rua.text,
                            bairro: bairro.text,
                            num: num.text,
                            complemento: complemento.text,
                            referencia: referencia.text
                        ));

                        Navigator.pop(context);

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Endereço atualizado com sucesso!')),
                        );
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 15, bottom: 15),
                      child: Text(
                        'Salvar',
                        style: TextStyle(color: Colors.white, fontSize: 15),
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
