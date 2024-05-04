import 'package:flutter/material.dart';
import 'dart:math';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController nomeController = TextEditingController();
  String? radioTabuleiro = "", radioSimbolo = "";
  String dados = "";
  bool jogoIniciado = false;
  String nomeJogador = '';

  List<List<String>> tabuleiro = [];

  void iniciarJogo() {
    setState(() {
      jogoIniciado = true;
      nomeJogador = nomeController.text;
      int tamanho = int.tryParse(radioTabuleiro ?? "") ?? 3;
      tabuleiro = List.generate(tamanho, (i) => List.generate(tamanho, (j) => ""));
    });
  }

  void reiniciarJogo() {
    setState(() {
      jogoIniciado = false;
      nomeJogador = '';
      nomeController.clear();
      radioTabuleiro = "";
      radioSimbolo = "";
      tabuleiro.clear();
    });
  }

  String mudarJogador() {
    return radioSimbolo = radioSimbolo == "X" ? "O" : "X";
  }

  void teste(){
    int tamanho = int.tryParse(radioTabuleiro ?? "") ?? 3;
    int intervalo = (tamanho * tamanho) - 1;
    
    Random random = Random();
    int randomNumber = 0 + random.nextInt(intervalo - 0 + 1);

    


  }

  Widget telaTabuleiro() {
    int tamanho = int.tryParse(radioTabuleiro ?? "") ?? 3;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Jogador: $nomeJogador'),
        Text('Tamanho do tabuleiro: $tamanho x $tamanho'),
        SizedBox(height: 20.0),
        
        ElevatedButton(
          onPressed: reiniciarJogo,
          child: Text("Novo Jogo"),
        ),
        
        Container(
          height: 400,
          width: 400,
          child: GridView.builder(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: tamanho,
              mainAxisSpacing: 5.0,
              crossAxisSpacing: 5.0,
            ),
            itemCount: tamanho * tamanho,
            itemBuilder: (context, index) {
              int linha = index ~/ tamanho;
              int coluna = index % tamanho;

              return GestureDetector(
                onTap: () {
                  setState(() {
                    tabuleiro[linha][coluna] = radioSimbolo ?? "";
                    print(tabuleiro);
                    radioSimbolo = mudarJogador();
                    teste();
                  });
                },
                
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Center(
                    child: Text(
                      tabuleiro[linha][coluna],
                      style: TextStyle(
                        fontSize: 50,
                        color: Colors.amber),
                    ),
                  ),
                ),
              );
            },
          )
        ),
      ],
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Jogo da Velha"),
        backgroundColor: Colors.blue,
      ),
      
      body: Center(
        child: Container(
          child: jogoIniciado ? telaTabuleiro() :
            Column(
              children: [
                SizedBox(height: 20.0),
                TextField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      labelText: "Insira o nome do jogador: ",
                      border: OutlineInputBorder()),
                  controller: nomeController,
                ),
                SizedBox(height: 20.0),
                
                Text('Escolha o tamanho do tabuleiro:'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Radio(
                        value: "3",
                        groupValue: radioTabuleiro,
                        onChanged: (String? value) {
                          radioTabuleiro = value;
                          setState(() {});
                        }),
                    Text("3x3"),
                    Radio(
                        value: "4",
                        groupValue: radioTabuleiro,
                        onChanged: (String? value) {
                          radioTabuleiro = value;
                          setState(() {});
                        }),
                    Text("4x4")
                  ],
                ),
                SizedBox(height: 20.0),
                
                Text('Escolha o seu símbolo:'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Radio(
                        value: "X",
                        groupValue: radioSimbolo,
                        onChanged: (String? value) {
                          radioSimbolo = value;
                          setState(() {});
                        }),
                    Text("X"),
                    Radio(
                        value: "O",
                        groupValue: radioSimbolo,
                        onChanged: (String? value) {
                          radioSimbolo = value;
                          setState(() {});
                        }),
                    Text("O")
                  ],
                ),
                SizedBox(height: 20.0),
                
                ElevatedButton(
                  onPressed: iniciarJogo, 
                  child: Text("Salvar")
                ),
              ],
            ),
        ),
      ),
    );
  }
}
