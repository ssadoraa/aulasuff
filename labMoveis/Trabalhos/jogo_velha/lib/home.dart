import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';

class Home extends StatefulWidget {
  const Home({Key? key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController nomeController = TextEditingController();
  String? radioTabuleiro = "", radioSimbolo = "", radioMaquina = "";
  String dados = "";
  bool jogoIniciado = false;
  String jogadorAtual = "";
  List<List<String>> tabuleiro = [];
  List<List<bool>> matriz = [];

  void iniciarJogo() {
    setState(() {
      jogoIniciado = true;
      jogadorAtual = nomeController.text;
      int tamanho = int.tryParse(radioTabuleiro ?? "") ?? 3;
      tabuleiro = List.generate(tamanho, (i) => List.generate(tamanho, (j) => ""));
      matriz = List.generate(tamanho, (_) => List.filled(tamanho, false));
    });
  }

  void reiniciarJogo() {
    setState(() {
      jogoIniciado = false;
      jogadorAtual = "";
      nomeController.clear();
      radioTabuleiro = "";
      radioSimbolo = "";
      tabuleiro.clear();
      matriz.clear();
    });
  }

  String mudarJogador() {
    return radioSimbolo == "X" ? "O" : "X";
  }

  List<List<bool>> jogadaMaquina(List<List<bool>> matriz) {
    Random random = Random();
    int linha = random.nextInt(matriz.length);
    int coluna = random.nextInt(matriz[0].length);

    while (matriz[linha][coluna]) {
      linha = random.nextInt(matriz[0].length);
      coluna = random.nextInt(matriz[0].length);
    }

    matriz[linha][coluna] = true;
    tabuleiro[linha][coluna] = radioMaquina ?? "";

    return matriz;
  }

  bool verificaVencedor(String simbolo) {
    for (int i = 0; i < tabuleiro.length; i++) {
      if (tabuleiro[i][0] == simbolo && tabuleiro[i][1] == simbolo && tabuleiro[i][2] == simbolo) {
        return true;
      }

      if (tabuleiro[0][i] == simbolo && tabuleiro[1][i] == simbolo && tabuleiro[2][i] == simbolo) {
        return true;
      }
    }

    if (tabuleiro[0][0] == simbolo && tabuleiro[1][1] == simbolo && tabuleiro[2][2] == simbolo) {
      return true;
    }

    if (tabuleiro[0][2] == simbolo && tabuleiro[1][1] == simbolo && tabuleiro[2][0] == simbolo) {
      return true;
    }
    return false;
  }

  Widget telaTabuleiro() {
    int tamanho = int.tryParse(radioTabuleiro ?? "") ?? 3;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('-> Jogador da vez: $jogadorAtual', style: TextStyle(fontSize: 25)),
        SizedBox(height: 30.0),
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
                    matriz[linha][coluna] = true;
                    radioMaquina = mudarJogador();
                    jogadorAtual = "Máquina";

                    if (verificaVencedor(radioSimbolo ?? "")) {
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: Text('Você venceu!'),
                          content: Text('Parabéns!'),
                          actions: [
                            ElevatedButton(
                              onPressed: reiniciarJogo,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color.fromARGB(255, 255, 232, 119),
                                foregroundColor: Colors.amber,
                              ),
                              child: Text("Novo jogo"),
                            ),
                          ],
                        ),
                      );
                    } else {
                      if (!verificaVencedor(radioSimbolo ?? "") && verificaVencedor(radioSimbolo ?? "")) {
                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: Text('Empate!'),
                            content: Text('Não houve vencedor.'),
                            actions: [
                              ElevatedButton(
                                onPressed: reiniciarJogo,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color.fromARGB(255, 255, 232, 119),
                                  foregroundColor: Colors.amber,
                                ),
                                child: Text("Novo jogo"),
                              ),
                            ],
                          ),
                        );
                      } else {
                        Future.delayed(Duration(seconds: 1), () {
                          setState(() {
                            matriz = jogadaMaquina(matriz);
                            jogadorAtual = nomeController.text;

                            if (verificaVencedor(radioMaquina ?? "")) {
                              showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                  title: Text('Máquina venceu!'),
                                  content: Text('Tente novamente!'),
                                  actions: [
                                    ElevatedButton(
                                      onPressed: reiniciarJogo,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Color.fromARGB(255, 255, 232, 119),
                                        foregroundColor: Colors.amber,
                                      ),
                                      child: Text("Novo jogo"),
                                    ),
                                  ],
                                ),
                              );
                            }
                          });
                        });
                      }
                    }
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
                      style: TextStyle(fontSize: 50, color: Colors.amber),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        
        SizedBox(height: 50.0),
        ElevatedButton(
          onPressed: reiniciarJogo,
          style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromARGB(255, 255, 232, 119),
            foregroundColor: Colors.amber,
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Text("Novo jogo"),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Jogo da Velha",
          style: TextStyle(
            color: Colors.amber,
            fontSize: 20
          ),
        ),
        backgroundColor: Color.fromARGB(255, 255, 232, 119),
      ),
      body: Center(
        child: Container(
          child: jogoIniciado ? telaTabuleiro() : Column(
            children: [
              SizedBox(height: 50.0),
              TextField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    labelText: "Insira o nome do jogador: ",
                    border: OutlineInputBorder()),
                controller: nomeController,
              ),
              SizedBox(height: 30.0),
              
              Text('Escolha o tamanho do tabuleiro:'),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Radio(
                      value: "3",
                      activeColor: Colors.amber,
                      groupValue: radioTabuleiro,
                      onChanged: (String? value) {
                        radioTabuleiro = value;
                        setState(() {});
                      }),
                  Text("3x3"),
                  Radio(
                      value: "4",
                      activeColor: Colors.amber,
                      groupValue: radioTabuleiro,
                      onChanged: (String? value) {
                        radioTabuleiro = value;
                        setState(() {});
                      }),
                  Text("4x4")
                ],
              ),
              SizedBox(height: 30.0),
              
              Text('Escolha o seu símbolo:'),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Radio(
                      value: "X",
                      activeColor: Colors.amber,
                      groupValue: radioSimbolo,
                      onChanged: (String? value) {
                        radioSimbolo = value;
                        setState(() {});
                      }),
                  Text("X"),
                  Radio(
                      value: "O",
                      activeColor: Colors.amber,
                      groupValue: radioSimbolo,
                      onChanged: (String? value) {
                        radioSimbolo = value;
                        setState(() {});
                      }),
                  Text("O")
                ],
              ),
              SizedBox(height: 30.0),
              
              ElevatedButton(
                onPressed: iniciarJogo,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 255, 232, 119),
                  foregroundColor: const Color.fromARGB(255, 254, 190, 0),
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text("Salvar"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
