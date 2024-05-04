import 'package:flutter/material.dart';

class Tela3 extends StatefulWidget {
  String name = "";

  Tela3();

  Tela3.name(this.name);
  
  @override
  State<Tela3> createState() => _Tela3State();
}

class _Tela3State extends State<Tela3> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tela três"),
        backgroundColor: Colors.greenAccent,
      ),
      
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [

              Text(widget.name!,
                style: TextStyle(
                  fontSize: 30
                ),
              ),

              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Voltar")
              )
            ],
          ),
        ),
      ),
    );

  }
}