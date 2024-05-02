import 'package:delivery_app/models/produto.dart';
import 'package:delivery_app/pages/produto_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyCard extends StatefulWidget {
  final Produto produto;
  const MyCard({super.key, required this.produto});

  @override
  State<MyCard> createState() => _MyCardState();
}

class _MyCardState extends State<MyCard> {
  mostrarDetalhes() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ProdutoDetails(
          produto: widget.produto,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double preco = widget.produto.valor;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), // Borda arredondada
      ),
      margin: EdgeInsets.only(top: 12),
      elevation: 2,
      child: InkWell(
        onTap: () {
          mostrarDetalhes();
        },
        child: Container(
          color: Colors.white,
          height: 100,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 200,
                  child: Row(
                    children: [
                      SizedBox(
                          width: 65,
                          child: Image.asset(widget.produto.img,
                              fit: BoxFit.fill)),
                      Container(
                        width: 130,
                        child: FittedBox(
                          child: Text(
                            widget.produto.nome,
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                                fontSize: 15),
                          ),
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.red[400],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: FittedBox(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5, bottom: 5),
                        child: Text(
                          'R\$ $preco',
                          style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 15,
                              color: Colors.white),
                        ),
                      ),
                      fit: BoxFit.scaleDown,
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
