import 'package:flutter/material.dart';
import 'package:navegacao_app/pages/arguments.dart';
import 'package:navegacao_app/pages/tela2.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  
  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        backgroundColor: Colors.blueAccent,
      ),
      
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              
              TextField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: "Nome"
                ),
                controller: nameController,
              ),

              ElevatedButton(
                onPressed: () {
                  /*Navigator.push(context,
                    MaterialPageRoute(
                      builder: (context) => Tela2.name(nameController.text)
                    )
                  );*/
                  Navigator.pushNamed(
                    context, 
                    Tela2.routeName,
                    arguments: Arguments(nameController.text));
                },
                child: Text("Próximo")
              )
            ],
          ),
        ),
      ),
    );
  }
}