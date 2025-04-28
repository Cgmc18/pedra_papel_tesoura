import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> opcoes = ["pedra", "papel", "tesoura"];
  String _mensagem = "Clique em Iniciar!";
  var imagemApp = const AssetImage("images/default.png");

  bool iniciado = false;
  Timer? _timer;
  String escolhaFinal = "";
  String? _escolhaUsuario;

  void _iniciar() {
    setState(() {
      iniciado = true;
      _escolhaUsuario = null;
      _mensagem = "Escolha uma opção!";
    });

    _timer = Timer.periodic(const Duration(milliseconds: 100), (_) {
      final i = Random().nextInt(opcoes.length);
      setState(() {
        imagemApp = AssetImage("images/${opcoes[i]}.png");
      });
    });
  }

  void _jogar(String escolha) {
    if (!iniciado) return;
    _timer?.cancel();

    final i = Random().nextInt(opcoes.length);
    escolhaFinal = opcoes[i];

    setState(() {
      _escolhaUsuario = escolha;
      imagemApp = AssetImage("images/$escolhaFinal.png");

      if (escolha == escolhaFinal) {
        _mensagem = "Empate :|";
      } else if ((escolha == "pedra" && escolhaFinal == "tesoura") ||
          (escolha == "papel" && escolhaFinal == "pedra") ||
          (escolha == "tesoura" && escolhaFinal == "papel")) {
        _mensagem = "Você venceu ;)";
      } else {
        _mensagem = "Você perdeu :(";
      }

      iniciado = false;
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Widget _buildBotaoIniciar() {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color.fromARGB(255, 45, 9, 104),
            width: 3,
          ),
          borderRadius: BorderRadius.circular(30),
          gradient: const LinearGradient(
            colors: [Colors.green, Colors.lightGreen],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(30),
            onTap: _iniciar,
            child: const SizedBox(
              width: 180,
              height: 50,
              child: Center(
                child: Text(
                  "Iniciar",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "JokenPo",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 191, 220, 247),
              Color.fromARGB(255, 212, 212, 212),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: const EdgeInsets.only(bottom: 100),
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Text(
                      "Escolha do App",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Image(image: imagemApp, height: 150),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Text(
                      _mensagem,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            if (iniciado || _escolhaUsuario != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children:
                      opcoes.map((opc) {
                        final selecionada = opc == _escolhaUsuario;
                        return GestureDetector(
                          onTap: iniciado ? () => _jogar(opc) : null,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration:
                                selecionada
                                    ? BoxDecoration(
                                      border: Border.all(
                                        color: Colors.blueAccent,
                                        width: 3,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    )
                                    : null,
                            child: Image.asset("images/$opc.png", height: 80),
                          ),
                        );
                      }).toList(),
                ),
              ),

            if (!iniciado)
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: _buildBotaoIniciar(),
              ),
          ],
        ),
      ),
    );
  }
}
