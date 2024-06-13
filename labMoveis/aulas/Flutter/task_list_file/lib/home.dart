import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:convert';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController taskController = TextEditingController();
  TextEditingController taskController2 = TextEditingController();
  List<dynamic> taskList = [];

  @override
  void initState(){
    super.initState();

    readFile().then((data) {
      taskList = jsonDecode(data);
      setState(() {});
    });
  }

  Future<String> readFile() async {
    final file = await getFile();
    return file.readAsString();
  }

  Widget listItemBuild(BuildContext context, int index){

    return Dismissible(
      key: Key(DateTime.now().microsecondsSinceEpoch.toString()),
      direction: DismissDirection.horizontal, 
      onDismissed: (direction) {
        print("Direction: ${direction.toString()}");

        var lastRemovedTask;

        if (direction == DismissDirection.startToEnd) {
            taskController2.text = taskList[index]["title"];

            showDialog(
              context: context, 
              builder: (context) {
                return AlertDialog(
                  title: Text("Atualizar Tarefa"),
                  content: TextField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: "Digite sua tarefa:"
                    ),
                    controller: taskController2,
                  ),
                  actions: [
                    TextButton(
                      child: Text("Cancelar"),
                      onPressed: () {
                        Navigator.pop(context);
                      } 
                    ),

                    TextButton(
                      child: Text("Atualizar"),
                      onPressed: () {
                        _updateTask(index);
                        Navigator.pop(context);
                      } 
                    )
                  ],
                );
              }
            );
        
        } else if (direction == DismissDirection.endToStart) {

          lastRemovedTask = taskList[index];
          taskList.removeAt(index);
          _saveFile();

          final snackBar = SnackBar(
            content: Text("Tarefa excluída!"),
            duration: Duration(seconds: 5),
            action: SnackBarAction(
              label: "Desfazer",
              onPressed: () {
                setState(() {
                  taskList.insert(index, lastRemovedTask);
                });
                _saveFile();
              },
            ),
          );

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      background: Container(
        color: Colors.green,
        padding: EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(Icons.edit, color: Colors.white,)
          ],
        ),
      ),
      secondaryBackground: Container(
        color: Colors.red,
        padding: EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(Icons.delete, color: Colors.white,)
          ],
        ),
      ),
      child: CheckboxListTile(
              title: Text(taskList[index]["title"]),
              value: taskList[index]["done"],
              onChanged: (bool? val) {
                taskList[index]["done"] = val;
                setState(() {});
                _saveFile();
              },
            )
      );
  }

  void _saveTask() {
    String taskStr = taskController.text;
    
    Map<String, dynamic> task = Map();
    task["title"] = taskStr;
    task["done"] = false;

    setState(() {
      taskList.add(task);
    });

    _saveFile();

  }

  void _updateTask(int index) {
    String taskStr = taskController2.text;


    setState(() {
      taskList[index]["title"] = taskStr;
    });

    _saveFile();

  }

  void _saveFile() async {
    final file = await getFile();
    
    String dataJson = jsonEncode(taskList);
    file.writeAsString(dataJson);
  }

  Future<File> getFile() async {
    final dir = await getApplicationDocumentsDirectory();
    String pathFile = dir.path + "/task.json";
    return File(pathFile);
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Tarefas"),
        backgroundColor: Colors.purple,
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.purple,
        onPressed: (){
          taskController.clear();
          showDialog(
            context: context, 
            builder: (context) {
              return AlertDialog(
                title: Text("Adicionar Tarefa"),
                content: TextField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: "Digite sua tarefa:"
                  ),
                  controller: taskController,
                ),
                actions: [
                  TextButton(
                    child: Text("Cancelar"),
                    onPressed: () {
                      Navigator.pop(context);
                    } 
                  ),

                  TextButton(
                    child: Text("Salvar"),
                    onPressed: () {
                      _saveTask();
                      Navigator.pop(context);
                    } 
                  )
                ],
              );
            }
          );
        },
      ),

      body: Container(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: taskList.length,
                itemBuilder: listItemBuild,
              )
            )
          ],
        ),
      )
    );
  }
}