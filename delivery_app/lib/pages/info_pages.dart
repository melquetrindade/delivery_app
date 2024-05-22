import 'package:delivery_app/repository/enderecoLoja.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({super.key});

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  late EnderecoLoja localizacaoLoja;
  late EnderecoLojaRepository enderecoDaLoja;

  @override
  Widget build(BuildContext context) {
    enderecoDaLoja = context.read<EnderecoLojaRepository>();
    localizacaoLoja = enderecoDaLoja.enderecoLoja;

    return Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: const Text(
            'Informações',
            style: TextStyle(
                color: Colors.red, fontSize: 18, fontWeight: FontWeight.w500),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
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
                        offset: Offset(1, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      ExpansionTile(
                        title: Text(
                          'Horarios de Funcionamento',
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.w500),
                        ),
                        leading: Icon(
                          Icons.access_time_filled,
                        ),
                        childrenPadding: EdgeInsets.symmetric(horizontal: 16.0),
                        expandedCrossAxisAlignment: CrossAxisAlignment.start,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                              color: Colors.transparent), // Remove as bordas
                        ),
                        children: [
                          ListTile(
                            title: Text('Segunda-Feira'),
                            subtitle: Text('Das 18:00 às 23:00'),
                          ),
                          ListTile(
                            title: Text('Terça-Feira'),
                            subtitle: Text('Das 18:00 às 23:00'),
                          ),
                          ListTile(
                            title: Text('Quarta-Feira'),
                            subtitle: Text('Das 18:00 às 23:00'),
                          ),
                          ListTile(
                            title: Text('Quinta-Feira'),
                            subtitle: Text('Das 18:00 às 23:00'),
                          ),
                          ListTile(
                            title: Text('Sexta-Feira'),
                            subtitle: Text('Das 18:00 às 23:30'),
                          ),
                          ListTile(
                            title: Text('Sábado'),
                            subtitle: Text('Das 18:00 às 23:30'),
                          ),
                          ListTile(
                            title: Text('Domingo'),
                            subtitle: Text('Das 18:00 às 23:00'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: Offset(1, 2),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 17),
                                child: Icon(
                                  Icons.location_on,
                                  size: 27,
                                ),
                              ),
                              Text(
                                'Endereço',
                                style: TextStyle(
                                    fontSize: 17,
                                    color: Colors.red,
                                    fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              child: Column(
                                children: [
                                  Container(
                                    width: double.infinity,
                                    child: Text(
                                      'Cidade: ${localizacaoLoja.cidade}',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.grey[700]),
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4),
                                    child: Container(
                                      width: double.infinity,
                                      child: Text(
                                        'Bairro: ${localizacaoLoja.bairro}',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.grey[700]),
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4),
                                    child: Container(
                                      width: double.infinity,
                                      child: Text(
                                        'Rua: ${localizacaoLoja.rua}, Nº ${localizacaoLoja.num} - ${localizacaoLoja.complemento}',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                            color: Colors.grey[700]),
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 2, bottom: 2),
                            child: Container(
                              width: 110,
                              child: OutlinedButton(
                                onPressed: () {
                                  // Ação a ser executada quando o botão for pressionado
                                },
                                style: OutlinedButton.styleFrom(
                                  side: BorderSide.none,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  backgroundColor: Colors.red, // Cor de fundo
                                ),
                                child: Text('Ver Mapa',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}


/*
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  minimumSize: MaterialStatePropertyAll(Size.zero),
                                  padding: MaterialStatePropertyAll(EdgeInsets.zero),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.red),
                                  shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(10)), // Raio dos cantos
                                        side: BorderSide.none, // Remove a borda
                                      ),
                                  ),
                                ),
                                onPressed: () {
                                  print('ver mapa');
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(top: 15, bottom: 15),
                                  child: Text(
                                    'Ver Mapa',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 12),
                                  ),
                                ),*/