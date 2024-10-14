import 'package:alerta_dengue/pages/home.dart';
import 'package:alerta_dengue/pages/results.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(MaterialApp(
    initialRoute: "/",
    routes: {
      Results.routeName: (context) => Results()
    },
    title: "Alerta Dengue",
    debugShowCheckedModeBanner: false,
    home: Home()
  ));
}
