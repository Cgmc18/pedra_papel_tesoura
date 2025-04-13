import 'dart:math';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List opcoes = ["pedra", "papel", "tesoura"];
  String _mensagem = "Escolha uma opção!";
  var imagemApp = AssetImage("images/default.png");

  void _jogar(String escolha) {
    int i = Random().nextInt(opcoes.length);
    String escolhaAleatoria = opcoes[i];
    print("OnTap: " + escolha + ", random: " + escolhaAleatoria);
    this.imagemApp = AssetImage("images/$escolhaAleatoria.png");

    if (escolha == "pedra" && escolhaAleatoria == "tesoura" ||
        escolha == "papel" && escolhaAleatoria == "pedra" ||
        escolha == "tesoura" && escolhaAleatoria == "papel") {
      setState(() {
        this._mensagem = "Você venceu ;)";
      });
    } else if (escolha == "pedra" && escolhaAleatoria == "papel" ||
        escolha == "papel" && escolhaAleatoria == "tesoura" ||
        escolha == "tesoura" && escolhaAleatoria == "pedra") {
      setState(() {
        this._mensagem = "Você perdeu :(";
      });
    } else {
      setState(() {
        this._mensagem = "Empate :|";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
        title: Container(
          color: Colors.green,
          padding: EdgeInsets.all(8),
          child: Text(
            "JokenPo",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(bottom: 150),
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
            Row(
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
            ),
          ],
        ),
      ),
    );
  }
}
