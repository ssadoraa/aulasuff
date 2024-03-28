import 'dart:io';

void printData(String nome, int idade, {double preco = 0.0}) {
  print("\nprintData -> Nome: ${nome}, idade: $idade, preco: $preco");
}

void printData2(Function idade) {
  idade;
}

void main() {
  print("Hello World");

  String nome = "Pedro";
  int idade = 12;
  double preco = 10.5;
  bool isAdulto = true;
  const pi = 3.14;

  var dado;
  dado = "\nDado";
  print(dado);
  dado = 100;
  print(dado);

  dynamic dado2 = "\nDado 2";
  print(dado2);
  dado2 = 5.1;
  print(dado2);
  
  print(idade);
  print(preco);
  print("\nNome: " + nome + ", idade: " +idade.toString());
  print("Nome: $nome, idade: $idade\n");

  var input = stdin.readLineSync();
  print("Read: $input");

  int val1 = 100, val2 = 50;
  print("\nAdição: ${val1 + val2}");
  print("Subtração: ${val1 - val2}");
  print("Multiplicação: ${val1 * val2}");
  print("Divisão: ${val1 / val2}");
  print("Resto: ${val1 % val2}");
  
  print("\n> : ${val1 > val2}"); 
  print("< : ${val1 < val2}"); 
  print(">= : ${val1 >= val2}"); 
  print("<= : ${val1 <= val2}"); 
  print("= : ${val1 == val2}"); 
  print("!= : ${val1 != val2}"); 

  print("\nAND ${val1 != val2 && val1 > 70}");
  print("OR ${val1 != val2 || val1 > 70}\n");

  if (idade <= 10) {
    print("Criança\n");
  } else if (idade > 10 && idade < 18) {
    print("Adolescente\n");
  } else {
    print("Adulto\n");
  }

  String op = "somar";

  switch(op) {
    case 'somar':
      print("Soma: ${val1 + val2}\n");
      break;

    case 'subtrair':
      print("Subtração: ${val1 - val2}\n");
      break;

    default:
      print("Operação desconhecida\n");
  }

  for (int i = 0; i < 5; i++){
    print("For: $i");
  }

  int j = 0;
  while (j < 5){
    print("While: $j");
    j++;
  }

  int k = 0;
  do {
    print("Do While: $k");
    k++;
  } while(k < 5);

  printData(nome, idade);
  printData(nome, idade, preco: 55.1);

  var idadeFuncao = (int idade) {
    print("\nFunção Anônima: ${idade}\n");
  };

  idadeFuncao(15);
  printData2(idadeFuncao);

  List<String> frutas = ["Maça", "Banana", "Uva"];
  for (String fruta in frutas){
    print("Frutas: ${fruta}");
  }

  frutas.remove(2);
  print("\nFrutas: ${frutas}\n");

  Map<String, String> estados = {
    "RJ": "Rio de Janeiro",
    "SP": "São Paulo",
    "MG": "Minas Gerais"
  };
  print(estados["RJ"]);

  estados.forEach((key, value) {
    print("key: $key, value: $value");
  });
}
