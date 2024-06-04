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
        backgroundColor: const Color.fromARGB(255, 252, 185, 165),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.deepOrange.shade900,
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: FutureBuilder<List<dynamic>>(
          future: encontraResultados(args),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData){
              List<dynamic>? results = snapshot.data;
              return ListView.builder(
                itemCount: results!.length,
                itemBuilder: (context, index) {
                  var week = results[index];
                  return Card(
                    child: ListTile(
                      title: Text('Semana: ${week['week']}'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Casos previstos: ${week['casos_est']}'),
                          Text('Casos notificados: ${week['casos']}'),
                          Text('Nível: ${week['nivel']}'),
                          Text('Temperatura mínima: ${week['tempmin']}°C'),
                          Text('Temperatura máxima: ${week['tempmax']}°C'),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else {
              return Text('Nenhum dado disponível');
            }
          },
        ),
      )
    );
  }
}

extension DateTimeExtension on DateTime {
  int get converterSemanaDoAno {
    int dayOfYear = int.parse(DateFormat("D").format(this));
    int woy = ((dayOfYear - weekday + 10) / 7).floor();
    return woy;
  }
}
