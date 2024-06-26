import 'package:delivery_app/pages/editEndereco.dart';
import 'package:delivery_app/repository/endereco.dart';
import 'package:delivery_app/repository/enderecoLoja.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ComponenteEndereco extends StatefulWidget {
  final bool isCheck;
  final Function toggleState;
  final EnderecoLoja localizacaoLoja;
  final Function endCliente;
  const ComponenteEndereco({
    super.key,
    required this.isCheck,
    required this.toggleState,
    required this.localizacaoLoja,
    required this.endCliente,
  });

  @override
  State<ComponenteEndereco> createState() => _ComponenteEnderecoState();
}

class _ComponenteEnderecoState extends State<ComponenteEndereco> {
  late Endereco localizacao;
  late EnderecoRepository endereco;

  navEditEndereco() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => EditEndereco(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    endereco = context.watch<EnderecoRepository>();
    localizacao = endereco.endereco;
    widget.endCliente(localizacao);

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        child: Column(
          children: [
            widget.isCheck == false
                ? 
                localizacao.rua == ''
                ?
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Endereço',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w400),
                      ),
                      IconButton(
                          onPressed: () {
                            navEditEndereco();
                          },
                          icon: Icon(
                            Icons.add_location_alt_outlined,
                            color: Colors.grey[600],
                          ))
                    ],
                  )
                :
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Endereço',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w400),
                      ),
                      IconButton(
                          onPressed: () {
                            navEditEndereco();
                          },
                          icon: Icon(
                            Icons.edit,
                            color: Colors.grey[600],
                          ))
                    ],
                  )
                : Padding(
                    padding: const EdgeInsets.only(bottom: 9),
                    child: Container(
                      width: double.infinity,
                      child: Text(
                        'Localização da Loja',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w400),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ),
            widget.isCheck == false
                ? 
                localizacao.rua == ''
                ?
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
                      padding: const EdgeInsets.all(14.0),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.yellow[100],
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Colors.yellow.shade600,
                                width: 1,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Icon(
                                      Icons.info,
                                      color: Colors.yellow[600],
                                    ),
                                  ),
                                  const Flexible(
                                    child: Text(
                                      'Você ainda não possui endereço de entrega. Adicione um para continuar!',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 12),
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                :
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
                      padding: const EdgeInsets.all(14.0),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.yellow[100],
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Colors.yellow.shade600,
                                width: 1,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Icon(
                                      Icons.info,
                                      color: Colors.yellow[600],
                                    ),
                                  ),
                                  const Flexible(
                                    child: Text(
                                      'Antes de continuar, revise se o endereço de entrega está correto.',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 12),
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 17),
                            child: Container(
                              width: double.infinity,
                              child: Text(
                                'Rua: ${localizacao.rua}, ${localizacao.num} - ${localizacao.complemento}',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 14),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            child: Text(
                              'Bairro: ${localizacao.bairro}',
                              textAlign: TextAlign.left,
                              style: TextStyle(fontSize: 14),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            child: Text(
                              'Referência: ${localizacao.referencia}',
                              textAlign: TextAlign.left,
                              style: TextStyle(fontSize: 14),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                : Container(
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
                      padding: const EdgeInsets.all(14.0),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.yellow[100],
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Colors.yellow.shade600,
                                width: 1,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Icon(
                                      Icons.info,
                                      color: Colors.yellow[600],
                                    ),
                                  ),
                                  const Flexible(
                                    child: Text(
                                      'Na seção INFO, você pode obter a localização da nossa loja no mapa.',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 12),
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 17),
                            child: Container(
                              width: double.infinity,
                              child: Text(
                                'Rua: ${widget.localizacaoLoja.rua}, ${widget.localizacaoLoja.num}',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 14),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            child: Text(
                              'Cidade: ${widget.localizacaoLoja.cidade}',
                              textAlign: TextAlign.left,
                              style: TextStyle(fontSize: 14),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            child: Text(
                              'Bairro: ${widget.localizacaoLoja.bairro}',
                              textAlign: TextAlign.left,
                              style: TextStyle(fontSize: 14),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
            CheckboxListTile(
              value: widget.isCheck,
              onChanged: (bool? newValue) {
                widget.toggleState(newValue);
              },
              activeColor: Colors.blue,
              checkColor: Colors.white,
              title: Text(
                'Buscar no estabelecimento!',
                style: TextStyle(fontSize: 13),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ),
      ),
    );
  }
}
