import 'package:delivery_app/repository/endereco.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ComponenteEndereco extends StatefulWidget {
  const ComponenteEndereco({super.key});

  @override
  State<ComponenteEndereco> createState() => _ComponenteEnderecoState();
}

class _ComponenteEnderecoState extends State<ComponenteEndereco> {
  late Endereco localizacao;
  late EnderecoRepository endereco;

  @override
  Widget build(BuildContext context) {
    endereco = context.read<EnderecoRepository>();
    localizacao = endereco.endereco;

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Endereço',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                ),
                IconButton(
                    onPressed: () {
                      print('editar endereço');
                    },
                    icon: Icon(
                      Icons.edit,
                      color: Colors.grey[600],
                    ))
              ],
            ),
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
                                style:
                                    TextStyle(color: Colors.black, fontSize: 12),
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
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
