import 'package:flutter/material.dart';

// Sua classe de modelo para fins de expansão futura do projeto
class TimelineStep {
  final String id;          
  final String question;    
  final List<String> options; 
  int? selectedOptionIndex;

  TimelineStep({
    required this.id,
    required this.question,
    required this.options,
    this.selectedOptionIndex,
  });
}

// O Widget da Linha Temporal que mostra a situação atual
class TimeLine extends StatelessWidget {
  final String textoNarrativa;

  const TimeLine({
    Key? key,
    required this.textoNarrativa,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.deepPurple.withValues(),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.deepPurple.withValues()),
      ),
      child: Text(
        textoNarrativa,
        style: const TextStyle(
          fontSize: 20, 
          fontWeight: FontWeight.bold,
          height: 1.4,
          color: Colors.white,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}