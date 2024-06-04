import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:alerta_dengue/model/arguments.dart';
import 'package:alerta_dengue/pages/results.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> tipoDoencas = ['chikungunya', 'dengue', 'zika'];
  String? doenca;
  int? estado, cidade;
  DateTime? dataInicio, dataFim;
  List<Map<String, dynamic>> cidades = [];

  Future<List<Map<String, dynamic>>> getEstados() async {
    String url = "https://servicodados.ibge.gov.br/api/v1/localidades/estados";
    http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      List<Map<String, dynamic>> estados = data.map((e) {
        return {
          'id': e['id'],
          'sigla': e['sigla'],
        };
      }).toList();

      estados.sort((a, b) => a['sigla'].compareTo(b['sigla']));
      return estados;
    } else {
      throw Exception('Falha ao carregar os estados!');
    }
  }

  Future<List<Map<String, dynamic>>> getCidades(int? estadoSelecionado) async {
    String url = "https://servicodados.ibge.gov.br/api/v1/localidades/estados/$estadoSelecionado/municipios";
    http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      List<Map<String, dynamic>> cidades = data.map((c) {
        return {
          'id': c['id'],
          'nome': c['nome'],
        };
      }).toList();

      cidades.sort((a, b) => a['nome'].compareTo(b['nome']));
      return cidades;
    } else {
      throw Exception('Falha ao carregar as cidades!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Alerta Dengue",
          style: TextStyle(
            fontSize: 16,
            color: Colors.deepOrange.shade900,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 252, 185, 165),
      ),
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [

              DropdownButton<String>(
                value: doenca,
                hint: Text('Selecione a doença'),
                items: tipoDoencas.map((String op) {
                  return DropdownMenuItem<String>(
                    value: op,
                    child: Text(op),
                  );
                }).toList(),
                onChanged: (String? doencaSelecionada) {
                  setState(() {
                    doenca = doencaSelecionada;
                  });
                },
              ),
              
              FutureBuilder<List<Map<String, dynamic>>>(
                future: getEstados(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    List<Map<String, dynamic>> estados = snapshot.data!;
                    return DropdownButton<int>(
                      value: estado,
                      hint: Text('Selecione o estado'),
                      items: estados.map((estado) {
                        return DropdownMenuItem<int>(
                          value: estado['id'],
                          child: Text(estado['sigla']),
                        );
                      }).toList(),
                      onChanged: (int? estadoSelecionado) {
                        setState(() {
                          estado = estadoSelecionado;
                          cidades = [];
                        });
                      },
                    );
                  } else {
                    return Text('Nenhum dado disponível');
                  }
                },
              ),

              FutureBuilder<List<Map<String, dynamic>>>(
                future: getCidades(estado),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Erro ao carregar estados: ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    List<Map<String, dynamic>> cidades = snapshot.data!;
                    return DropdownButton<int>(
                      value: cidade,
                      hint: Text('Selecione a cidade'),
                      items: cidades.map((cidade) {
                        return DropdownMenuItem<int>(
                          value: cidade['id'],
                          child: Text(cidade['nome']),
                        );
                      }).toList(),
                      onChanged: (int? cidadeSelecionado) {
                        setState(() {
                          cidade = cidadeSelecionado;
                        });
                      },
                    );
                  } else {
                    return Text('Nenhum dado disponível');
                  }
                },
              ),
              
              TextButton(
                onPressed: () async {
                  final DateTime? dataInicioEscolhida = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (dataInicioEscolhida != null) {
                    setState(() {
                      dataInicio = dataInicioEscolhida;
                    });
                  }
                },
                child: Text(
                  dataInicio == null
                      ? 'Selecione a data da semana do início'
                      : 'Data de início: ${dataInicio!.toString().split(' ')[0]}',
                ),
              ),

              TextButton(
                onPressed: () async {
                  final DateTime? dataFinalEscolhida = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (dataFinalEscolhida != null) {
                    setState(() {
                      dataFim = dataFinalEscolhida;
                    });
                  }
                },
                child: Text(
                  dataFim == null
                      ? 'Selecione a data da semana do final'
                      : 'Data de fim: ${dataFim!.toString().split(' ')[0]}',
                ),
              ),

              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    Results.routeName,
                    arguments: Arguments(
                      doenca!,
                      cidade!,
                      dataInicio!,
                      dataFim!
                    ),
                  );
                },
                child: Text("Consultar"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
