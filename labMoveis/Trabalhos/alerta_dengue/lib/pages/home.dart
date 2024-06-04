import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:alerta_dengue/model/arguments.dart';
import 'package:alerta_dengue/pages/results.dart';
import 'package:intl/intl.dart';

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

  void limparCampos() {
    setState(() {
      doenca = null;
      estado = null;
      cidade = null;
      dataInicio = null;
      dataFim = null;
    });
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
        title: Row(
          children: [
            Icon(Icons.health_and_safety, color: Colors.deepOrange.shade900),
            SizedBox(width: 10),
            Text(
              "Alerta Dengue",
              style: TextStyle(
                fontSize: 16,
                color: Colors.deepOrange.shade900,
              ),
            ),
          ],
        ),
        backgroundColor: Color.fromARGB(255, 252, 185, 165),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(80),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.warning_amber_rounded,
                color: Colors.deepOrange,
                size: 48,
              ),

              SizedBox(height: 30),
              Text(
                "Bem-vindo ao Alerta Dengue!\n Informe os dados abaixo para obter informações sobre casos de doenças transmitidas por mosquitos na sua cidade.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: Color.fromARGB(255, 107, 107, 107),
                ),
              ),

              SizedBox(height: 50),
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

              SizedBox(height: 45),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
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
                ],
              ),

              SizedBox(height: 45),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
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
                          ? 'Selecione a data do início'
                          : "Data Início: ${DateFormat('dd/MM/yyyy').format(dataInicio!)}",
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 107, 107, 107),
                      ),
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
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 107, 107, 107)
                      ),
                      dataFim == null
                          ? 'Selecione a data do final'
                          : "Data Fim: ${DateFormat('dd/MM/yyyy').format(dataFim!)}",
                    ),
                  ),
                ],
              ),

              SizedBox(height: 100),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 252, 185, 165)),
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.only(top: 20, bottom: 20, left: 40, right: 40)),                
                ),
                onPressed: () async {
                  final result = await Navigator.pushNamed(
                    context,
                    Results.routeName,
                    arguments: Arguments(
                      doenca!,
                      cidade!,
                      dataInicio!,
                      dataFim!
                    ),
                  );

                  if (result == true) {
                    limparCampos();
                  }
                },
                child: Text(
                  "Consultar",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),

              SizedBox(height: 25),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 252, 185, 165)),
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.all(20)),
                ),
                onPressed: () {
                    limparCampos();
                },
                child: Text(
                  "Limpar campos",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
