import 'package:delivery_app/repository/enderecoLoja.dart';
import 'package:delivery_app/services/notificationsLocal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({super.key});

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  late EnderecoLoja localizacaoLoja;
  late EnderecoLojaRepository enderecoDaLoja;
  late List<Horario> horarios;
  late List<String> telefones;
  bool isCheck = false;

  void _launchMaps(double lat, double lng) async {
    final url = 'https://www.google.com/maps/search/?api=1&query=$lat,$lng';
    // ignore: deprecated_member_use
    if (await canLaunch(url)) {
      // ignore: deprecated_member_use
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    enderecoDaLoja = context.watch<EnderecoLojaRepository>();
    localizacaoLoja = enderecoDaLoja.enderecoLoja;
    horarios = enderecoDaLoja.horariosLoja;
    telefones = enderecoDaLoja.telefonesLoja;

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
                          for (var i = 0; i < horarios.length; i++)
                            listaHorarios(i)
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
                                        'Rua: ${localizacaoLoja.rua}, Nº ${localizacaoLoja.num}',
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
                                  _launchMaps(-6.6941727, -36.6569032);
                                },
                                style: OutlinedButton.styleFrom(
                                  side: BorderSide.none,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  backgroundColor: Colors.red, // Cor de fundo
                                ),
                                child: Text(
                                  'Ver Mapa',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 13),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
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
                    child: Column(
                      children: [
                        ExpansionTile(
                          title: Text(
                            'Telefones',
                            style: TextStyle(
                                color: Colors.red, fontWeight: FontWeight.w500),
                          ),
                          leading: Icon(
                            Icons.call,
                          ),
                          childrenPadding:
                              EdgeInsets.symmetric(horizontal: 16.0),
                          expandedCrossAxisAlignment: CrossAxisAlignment.start,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                color: Colors.transparent), // Remove as bordas
                          ),
                          children: [
                            telefones.isEmpty
                                ? Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'A loja não possui telefones cadastrados!',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400),
                                    ),
                                  )
                                : Column(
                                    children:
                                        telefones.asMap().entries.map((entry) {
                                      int index = entry.key;
                                      return listaTelefones(index);
                                    }).toList(),
                                  ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
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
                    child: CheckboxListTile(
                      value: isCheck,
                      onChanged: (bool? newValue) {
                        setState(() {
                          isCheck = newValue!;
                          if (isCheck) {
                            Provider.of<NotificationService>(context,
                                    listen: false)
                                .showNotification(CustomNotification(
                                    id: 2,
                                    title: 'Teste',
                                    body: 'Acesse o app!',
                                    payload: '/notificacao'));
                          }
                        });
                      },
                      activeColor: Colors.blue,
                      checkColor: Colors.white,
                      title: Text(
                        'Enviar notificação!',
                        style: TextStyle(fontSize: 13),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  Widget listaHorarios(int index) {
    String diaSemana() {
      if (horarios[index].dia == 'segunda') {
        return 'Segunda-Feira';
      } else if (horarios[index].dia == 'terca') {
        return 'Terça-Feira';
      } else if (horarios[index].dia == 'quarta') {
        return 'Quarta-Feira';
      } else if (horarios[index].dia == 'quinta') {
        return 'Quinta-Feira';
      } else if (horarios[index].dia == 'sexta') {
        return 'Sexta-Feira';
      } else if (horarios[index].dia == 'sabado') {
        return 'Sábado';
      }
      return 'Domingo';
    }

    return ListTile(
      title: Text(diaSemana()),
      subtitle: Text(horarios[index].status
          ? 'Das ${horarios[index].abre} às ${horarios[index].fecha}'
          : 'Fechado'),
    );
  }

  Widget listaTelefones(int index) {
    return ListTile(
      title: Text('Telefone ${index + 1}'),
      subtitle: Text(telefones[index]),
    );
  }
}