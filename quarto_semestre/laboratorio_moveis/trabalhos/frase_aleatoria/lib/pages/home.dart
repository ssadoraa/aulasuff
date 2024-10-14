import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> {

  Random random = Random();

  List<String> frases = [
    "O segredo do sucesso é a constância do propósito. - Benjamin Disraeli",
    "Não importa o quão devagar você vá, desde que você não pare. - Confúcio",
    "O sucesso é a soma de pequenos esforços repetidos dia após dia. - Robert Collier",
    "Acredite em si mesmo e todo o resto se encaixará. Tenha fé em suas próprias habilidades, não em sorteios aleatórios da sorte. - Norman Vincent Peale",
    "Você é mais corajoso do que acredita, mais forte do que parece e mais inteligente do que pensa. - A.A. Milne"
  ];

  String mensagem = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Frases Aleatórias",
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.white)),
        backgroundColor: Color.fromARGB(255, 183, 216, 144),
      ),
      body: Center(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "images/title.png",
                width: 300,
                height: 300,
              ),
              SizedBox(height: 20),
              Text(
                mensagem,
                style: TextStyle(
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text(
                "Clique abaixo para gerar uma frase!",
                style: TextStyle(
                  fontSize: 16
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    mensagem = frases[random.nextInt(frases.length)];
                  });
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 174, 223, 176)),
                ),
                child: Text(
                  "Clique aqui!",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}