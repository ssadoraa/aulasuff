import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({super.key});
  
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController cepController = TextEditingController();
  String logradouro = "", bairro = "", cidade = "";

  void getCep() async {
    String cep = cepController.text;
    String url = "https://viacep.com.br/ws/$cep/json/";
    http.Response response = await http.get(Uri.parse(url));

    print(response.statusCode);
    print(response.body);

    Map<String, dynamic> ret = jsonDecode(response.body);
    logradouro = ret["logradouro"];
    bairro = ret["bairro"];
    cidade = ret["cidade"];

    print(ret["logradouro"]);
    print(ret["bairro"]);
    print(ret["localidade"]);

    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Via Cep"),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Container(
          child: Column(
            children: [
              TextField(
                keyboardType: TextInputType.text,
                controller: cepController,
                decoration: InputDecoration(
                  labelText: "Cep:"
                ),
              ),

              ElevatedButton(
                onPressed: getCep, 
                child: Text("Buscar")
              ),

              Text("Logradouro: $logradouro"),
              Text("Bairro: $bairro"),
              Text("Cidade: $cidade")
            ],
          ),
        ),
      ),
    );
  }
}