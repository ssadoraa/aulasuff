import 'package:flutter/material.dart';
import 'package:frase_aleatoria/pages/home.dart';

void main() {
  runApp(MaterialApp(
    title: "Frases Aleatórias do Dia",
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      useMaterial3: true,
    ),
    home: Home()
  ));
}