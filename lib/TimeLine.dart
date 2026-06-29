import 'package:flutter/material.dart';

// O Widget da Linha Temporal que agora mostra Imagem + Texto
class TimeLine extends StatelessWidget {
  final String textoNarrativa;
  final String caminhoImagem; // <-- Nova propriedade

  const TimeLine({
    Key? key,
    required this.textoNarrativa,
    required this.caminhoImagem, // <-- Obrigatório receber
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.deepPurple.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.deepPurple.withOpacity(0.2)),
      ),
      child: Column( // Mudamos para Column para colocar a imagem acima do texto
        children: [
          // Exibe a imagem da pasta uploads
          ClipRRect(
  borderRadius: BorderRadius.circular(8),
  child: Image.asset(
    caminhoImagem,
    key: ValueKey(caminhoImagem), // <--- ADICIONE ESTA LINHA AQUI
    height: 200,
    width: double.infinity,
    fit: BoxFit.cover,
    errorBuilder: (context, error, stackTrace) {
      return const Icon(
        Icons.image_not_supported, 
        size: 100, 
        color: Colors.grey,
      );
    },
  ),
),
          const SizedBox(height: 16), // Espaço entre a imagem e o texto
          Text(
            textoNarrativa,
            style: const TextStyle(
              fontSize: 20, 
              fontWeight: FontWeight.bold,
              height: 1.4,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}