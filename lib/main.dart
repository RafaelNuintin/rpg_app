import 'dart:convert'; // Necessário para converter o JSON string
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle; // Necessário para carregar o arquivo
import 'TimeLine.dart';
import 'escolhas.dart';

void main() => runApp(RpgViagemNoTempo());

class RpgViagemNoTempo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: JogoPage(),
    );
  }
}

class JogoPage extends StatefulWidget { 
  @override
  _JogoPageState createState() => _JogoPageState();
}

class _JogoPageState extends State<JogoPage> {
  final List<int> _historicoIndices = [0]; 
  List<Map<String, Object>> _perguntas = []; 
  
  late Future<void> _carregamentoFuturo;

  @override
  void initState() {
    super.initState();
    _carregamentoFuturo = _carregarDadosJson();
  }

  Future<void> _carregarDadosJson() async {
    if (_perguntas.isEmpty) {
      final String respostaJson = await rootBundle.loadString('uploads/historias.json');
      final List<dynamic> dados = json.decode(respostaJson);
      
      _perguntas = dados.map((item) {
        return {
          'id': item['id'] as int,
          'texto': item['texto'] as String,
          'imagem': item['imagem'] as String,
          'respostas': (item['respostas'] as List<dynamic>).map((resp) {
            return {
              'texto': resp['texto'] as String,
              'proximoId': resp['proximoId'] as int,
            };
          }).toList(),
        };
      }).toList();
    }
  }

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

  // NOVA FUNÇÃO: Reinicia o fluxo do jogo voltando ao primeiro passo
  void _reiniciarJogo() {
    setState(() {
      _historicoIndices.clear();
      _historicoIndices.add(0); // Restaura o ponto inicial (ID 0)
    });
  }

  // MECÂNICA DE VOLTAR NO TEMPO (Desfazer última escolha)
  void _voltarNoTempo() {
    if (_historicoIndices.length > 1) {
      setState(() {
        _historicoIndices.removeLast(); 
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RPG: Paradoxo Temporal'),
        backgroundColor: Colors.deepPurple, 
      ),
      body: FutureBuilder(
        future: _carregamentoFuturo,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.deepPurple),
            );
          }

          if (snapshot.hasError) {
            print("ERRO DO JSON: ${snapshot.error}"); 
            return const Center(
              child: Text('Erro ao carregar a linha temporal.'),
            );
          }

          final pergunta = _perguntaAtual;
          final respostas = pergunta['respostas'] as List<Map<String, Object>>;
          bool jogoAcabou = respostas.isEmpty;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TimeLine(
                  textoNarrativa: pergunta['texto'] as String,
                  caminhoImagem: pergunta['imagem'] as String,
                ),
                
                const SizedBox(height: 30),

                // OPERADOR TERNÁRIO: Controla se exibe a tela de Fim + Reiniciar ou os botões de Escolhas
                jogoAcabou
                    ? Column(
                        children: [
                          const Text(
                            'Fim da sua Linha do Tempo!',
                            style: TextStyle(color: Colors.red, fontSize: 18, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton.icon(
                            onPressed: _reiniciarJogo,
                            icon: const Icon(Icons.refresh),
                            label: const Text('Reiniciar Linha Temporal'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              minimumSize: const Size.fromHeight(50),
                            ),
                          ),
                        ],
                      )
                    : Escolhas(
                        respostas: respostas,
                        onResponder: _responder,
                      ),

                const SizedBox(height: 40),
                const Divider(),
              ],
            ),
          );
        },
      ),
    );
  }
}