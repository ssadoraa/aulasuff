import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:alerta_dengue/model/arguments.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class Results extends StatefulWidget {
  static String routeName = "/results";

  @override
  State<Results> createState() => _ResultsState();
}

class _ResultsState extends State<Results> {

  Future<List<dynamic>> encontraResultados(Arguments args) async {
    String baseUrl = 'https://info.dengue.mat.br/api/alertcity';
    int geocode = args.municipioId;
    String disease = args.doenca;
    String format = 'json';
    int ewStart = args.dataInicio.converterSemanaDoAno;
    int ewEnd = args.dataFim.converterSemanaDoAno;
    int eyStart = args.dataInicio.year;
    int eyEnd = args.dataFim.year;

    String url = '$baseUrl?geocode=$geocode&disease=$disease&format=$format&ew_start=$ewStart&ew_end=$ewEnd&ey_start=$eyStart&ey_end=$eyEnd';
    http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Falha ao carregar os resultados!');
    }
  }

  @override
  Widget build(BuildContext context) {
    Arguments args = ModalRoute.of(context)!.settings.arguments as Arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Alerta Dengue - Resultados",
          style: TextStyle(
            fontSize: 16,
            color: Colors.deepOrange.shade900,
          ),
        ),
        backgroundColor: Color.fromARGB(255, 252, 185, 165),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.deepOrange.shade900,
          onPressed: () => Navigator.pop(context, true),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 40),
          Padding(
            padding: EdgeInsets.all(6.0),
            child: Text(
              "Resultados para os filtros:",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.all(6.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Município: ${args.municipioId}",
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(width: 10),
                Text(
                  "Doença: ${args.doenca}",
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          
          Padding(
            padding: EdgeInsets.all(6.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Data Início: ${DateFormat('dd/MM/yyyy').format(args.dataInicio)}",
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(width: 10),
                Text(
                  "Data Fim: ${DateFormat('dd/MM/yyyy').format(args.dataFim)}",
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),

          SizedBox(height: 15),
          Expanded(
            child: FutureBuilder<List<dynamic>>(
              future: encontraResultados(args),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else if (snapshot.hasData) {
                  List<dynamic>? resultados = snapshot.data;
                  return ListView.builder(
                    itemCount: resultados!.length,
                    itemBuilder: (context, index) {
                      var semana = resultados[index];
                      return Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Card(
                          child: ListTile(
                            title: Text('Semana: ${index + 1}'),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Casos previstos: ${semana['casos_est']}'),
                                Text('Casos notificados: ${semana['casos']}'),
                                Text('Nível: ${semana['nivel']}'),
                                Text('Temperatura mínima: ${semana['tempmin']}°C'),
                                Text('Temperatura máxima: ${semana['tempmax']}°C'),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return Center(
                    child: Text('Nenhum dado disponível'),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

extension DateTimeExtension on DateTime {
  int get converterSemanaDoAno {
    int dia = int.parse(DateFormat("D").format(this));
    return ((dia - weekday + 10) / 7).floor();
  }
}
