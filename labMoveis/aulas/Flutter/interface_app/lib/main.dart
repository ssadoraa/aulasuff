import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      title: "Interface App",
      debugShowCheckedModeBanner: false,
      home: Container(
        padding: EdgeInsets.all(20),
        // padding: EdgeInsets.only(top: 120, left: 10, right: 10, bottom: 100),
        // margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.lightGreen,
            border: Border.all(width: 3, color: Colors.blue)),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          // crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text("Widget 1"),
            Text("Container 2",
                style: TextStyle(
                    fontSize: 30,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    letterSpacing: 10,
                    decoration: TextDecoration.none,
                    decorationColor: Colors.red,
                    decorationStyle: TextDecorationStyle.dotted)),
            Text("Widget 3"),
            TextButton(
              onPressed: (){
                print("Clicado");
              }, 
              child: Text("Clique aqui")
              ),
            ElevatedButton(
              onPressed: (){
                print("Clicado");
              }, 
              child: Text("Clique aqui")),
              GestureDetector(
                onTap: (){
                  print("Gesture Detector");
                },
                child: Text("TEXT com Gesture Detector"),
              )
          ],
        ),
      ),
    ),
  );
}