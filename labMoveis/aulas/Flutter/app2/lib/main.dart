import 'package:app2/pages/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: "Interface com Scaffold",
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      useMaterial3: true,
    ),
    home: Home()
  ));
}