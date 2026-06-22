import 'package:flutter/material.dart';

class Escolhas extends StatelessWidget {
  final List<Map<String, Object>> respostas;
  final Function(int) onResponder; // Callback para comunicar com o main.dart

  const Escolhas({
    Key? key,
    required this.respostas,
    required this.onResponder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: respostas.map((resposta) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: ElevatedButton( // Requisito Obrigatório
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purpleAccent,
              minimumSize: const Size.fromHeight(50), // Melhora o clique
            ),
            onPressed: () => onResponder(resposta['proximoId'] as int),
            child: Text(
              resposta['texto'] as String,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
                ),
            ),
          ),
        );
      }).toList(),
    );
  }
}