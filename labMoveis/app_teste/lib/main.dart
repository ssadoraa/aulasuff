import 'package:flutter/material.dart';
import 'view/login.dart';

final routes = {
  "/": (context) => Login(),
  "/login": (context) => Login()
};

void main() {
  runApp(MaterialApp(
    title: "Login App",
    debugShowCheckedModeBanner: false,
    routes: routes
  ));
}