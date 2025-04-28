import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> opcoes = ["pedra", "papel", "tesoura"];
  String _mensagem = "Clique em Iniciar!";
  var imagemApp = AssetImage("images/default.png");

  bool iniciado = false;
  Timer? _timer;
  String escolhaFinal = "";

  void _iniciar() {
    setState(() {
      iniciado = true;
      _mensagem = "Escolha uma opção!";
    });

    _timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      int i = Random().nextInt(opcoes.length);
      setState(() {
        imagemApp = AssetImage("images/${opcoes[i]}.png");
      });
    });
  }

  void _jogar(String escolha) {
    if (!iniciado) return;

    _timer?.cancel();
    int i = Random().nextInt(opcoes.length);
    escolhaFinal = opcoes[i];
    setState(() {
      imagemApp = AssetImage("images/$escolhaFinal.png");
    });

    if (escolha == escolhaFinal) {
      setState(() {
        _mensagem = "Empate :|";
      });
    } else if ((escolha == "pedra" && escolhaFinal == "tesoura") ||
        (escolha == "papel" && escolhaFinal == "pedra") ||
        (escolha == "tesoura" && escolhaFinal == "papel")) {
      setState(() {
        _mensagem = "Você venceu ;)";
      });
    } else {
      setState(() {
        _mensagem = "Você perdeu :(";
      });
    }

    iniciado = false; 
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
        title: Text(
          "JokenPo",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
     body: Container(
  decoration: BoxDecoration(
    gradient: LinearGradient(
      colors: [
        const Color.fromARGB(255, 191, 220, 247),
        const Color.fromARGB(255, 212, 212, 212),
      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ),
  ),
  padding: EdgeInsets.only(bottom: 100),
  child: Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
            Padding(
              padding: EdgeInsets.only(top: 32, bottom: 16),
              child: Text(
                "Escolha do App",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Image(image: imagemApp, height: 150),
            Padding(
              padding: EdgeInsets.only(top: 32, bottom: 16),
              child: Text(
                _mensagem,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
           iniciado
  ? Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () => _jogar("papel"),
          child: Image.asset("images/papel.png", height: 100),
        ),
        GestureDetector(
          onTap: () => _jogar("pedra"),
          child: Image.asset("images/pedra.png", height: 100),
        ),
        GestureDetector(
          onTap: () => _jogar("tesoura"),
          child: Image.asset("images/tesoura.png", height: 100),
        ),
      ],
    )
  : Center(
  child: Container(
    decoration: BoxDecoration(
      border: Border.all(
        color: Color.fromARGB(255, 45, 9, 104),
        width: 3,
      ),
      borderRadius: BorderRadius.circular(30),
      gradient: LinearGradient(
        colors: [
          Colors.green,
          Colors.lightGreen,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(30),
        onTap: _iniciar,
        child: Container(
          width: 200,
          height: 60,
          alignment: Alignment.center,
          child: Text(
            "Iniciar",
            style: TextStyle(
              fontSize: 24,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    ),
  ),
)

          ],
        ),
      ),
    );
  }
}
