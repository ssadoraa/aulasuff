import 'package:flutter/material.dart';
import 'package:posts_app/home.dart';

void main(){
  runApp(
    MaterialApp(
        title: "Posts App",
        debugShowCheckedModeBanner: false,
        home: Home(),
    )
  );
}