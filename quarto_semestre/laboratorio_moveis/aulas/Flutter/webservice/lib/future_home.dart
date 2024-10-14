import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FutureHome extends StatefulWidget {
  const FutureHome({super.key});
  
  @override
  State<FutureHome> createState() => _FutureHomeState();
}

class _FutureHomeState extends State<FutureHome> {

  TextEditingController cepController = TextEditingController();
  String logradouro = "", bairro = "", cidade = "";

  Future<Map> getCep() async {
    if(cepController.text.isNotEmpty){
      String cep = cepController.text;
      String url = "https://viacep.com.br/ws/$cep/json/";
      http.Response response = await http.get(Uri.parse(url));

      Map<String, dynamic> ret = jsonDecode(response.body);
      logradouro = ret["logradouro"];
      bairro = ret["bairro"];
      cidade = ret["cidade"];
      
      return ret;
    } else {
      return {
        "logradouro": "",
        "bairro":"",
        "localidade": ""
      };
    }

  }

  @override
  Widget build(BuildContext) {
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

              FutureBuilder(
                future: getCep(), 
                builder: (context, snapshot) {
                  String result = "";
                  if (snapshot.hasData) {
                    result = snapshot.data!["bairro"];
                  } else if (snapshot.hasError) {
                    result = snapshot.error.toString();
                  } else {
                    return CircularProgressIndicator();
                  }

                  return Text(result);
                }
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