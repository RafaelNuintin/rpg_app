import 'package:flutter/material.dart';
// Importação dos seus novos módulos de código
import 'TimeLine.dart';
import 'escolhas.dart';

void main() => runApp(RpgViagemNoTempo());

class RpgViagemNoTempo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp( // Requisito Obrigatório
      debugShowCheckedModeBanner: false,
      home: JogoPage(),
    );
  }
}

class JogoPage extends StatefulWidget { // Requisito Obrigatório 
  @override
  _JogoPageState createState() => _JogoPageState();
}

class _JogoPageState extends State<JogoPage> {
  final List<int> _historicoIndices = [0]; 

  final List<Map<String, Object>> _perguntas = [
    {
      'texto': 'Você está em 1980. Desenvolve um dispositivo tecnológico tecnicamente capaz de modificar o fluxo temporal e a organização da realidade. Porém, o objeto parece estar um pouco instável.',
      'respostas': [
        {'texto': 'Tentar utilizá-lo para avalizar seu funcionamento', 'proximoId': 1},
        {'texto': 'Usar um pedaço de ferro comum', 'proximoId': 2},
      ],
    },
    {
      'texto': 'Na oficina, você encontrou cobre puro. O conserto funcionou e você avançou!',
      'respostas': [
        {'texto': 'Viajar para o Futuro (2099)', 'proximoId': 3},
        {'texto': 'Ficar no passado', 'proximoId': 4},
      ],
    },
    {
      'texto': 'O ferro comum derreteu e explodiu a máquina. Você está preso em 1920!',
      'respostas': [
        {'texto': 'Tentar consertar de novo (Mudar o passado)', 'proximoId': 0},
      ],
    },
    {
      'texto': 'Em 2099 os carros voam, mas a atmosfera está poluída. Você venceu o jogo explorador!',
      'respostas': [],
    },
    {
      'texto': 'Você virou uma lenda local em 1920, mas perdeu a sua linha temporal.',
      'respostas': [],
    },
  ];

  // GETTER - Requisito Obrigatório 
  Map<String, Object> get _perguntaAtual { 
    int idAtual = _historicoIndices.last;
    return _perguntas[idAtual];
  }

  // CALLBACK / FUNÇÃO
  void _responder(int proximoId) {
    setState(() {
      _historicoIndices.add(proximoId); 
    });
  }

  // MECÂNICA DE APAGAR O PASSADO
  void _voltarNoTempo() {
    if (_historicoIndices.length > 1) {
      setState(() {
        _historicoIndices.removeLast(); 
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final pergunta = _perguntaAtual;
    final respostas = pergunta['respostas'] as List<Map<String, Object>>;
    bool jogoAcabou = respostas.isEmpty;

    return Scaffold( // Requisito Obrigatório
      appBar: AppBar(
        title: const Text('RPG: Paradoxo Temporal'), // Requisito Obrigatório
        backgroundColor: Colors.deepPurple, 
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column( // Requisito Obrigatório
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 1. Usando seu widget modularizado de Linha Temporal!
            TimeLine(textoNarrativa: pergunta['texto'] as String),
            
            const SizedBox(height: 30),

            // OPERADOR TERNÁRIO - Requisito Obrigatório
            jogoAcabou
                ? const Text(
                    'Fim da sua Linha do Tempo!',
                    style: TextStyle(color: Colors.red, fontSize: 18, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  )
                : Escolhas( // 2. Usando seu widget modularizado de Escolhas!
                    respostas: respostas,
                    onResponder: _responder,
                  ),

            const SizedBox(height: 40),
            const Divider(),

            // Botão de Viagem no Tempo para apagar a última escolha
            ElevatedButton.icon(
              onPressed: _historicoIndices.length > 1 ? _voltarNoTempo : null,
              icon: const Icon(Icons.history), 
              label: const Text(
                'Desfazer Escolha (Voltar no Tempo)',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 147, 194, 218)),
            ),
          ],
        ),
      ),
    );
  }
}