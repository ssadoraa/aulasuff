import 'package:flutter/material.dart';
import 'package:navegacao_app/pages/home.dart';
import 'package:navegacao_app/pages/tela2.dart';
import 'package:navegacao_app/pages/tela3.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: "/",
    routes: {
      Tela2.routeName: (context) => Tela2(),
      "/tela3": (context) => Tela3()
    },
    title: "Navigator App",
    debugShowCheckedModeBanner: false,
    home: Home(),
  ));
}