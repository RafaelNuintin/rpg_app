import 'package:flutter/material.dart';

class Resposta extends StatelessWidget {
 
  final String texto;
  // final VoidCallback() quandoSelecionado;
  final void Function() quandoSelecionado;

  Resposta(this.texto, this.quandoSelecionado);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      width: double.infinity,

      child: ElevatedButton(
        onPressed: quandoSelecionado, 
        child: Text(
          texto,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        ),
    );
  }
}