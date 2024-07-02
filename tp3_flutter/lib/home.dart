import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tp3_flutter/drawer.dart';
import 'package:tp3_flutter/task.dart';

import 'creation.dart';
import 'lib_http.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Task> taskItems = [];
  bool hasError = false;

  @override
  void initState() {
    super.initState();
getTasks();
  }
  var taskDocs;

  void getTasks() async
  {
    CollectionReference<Task> tasksCollection = getTasksCollection();
    QuerySnapshot<Task> results = await tasksCollection.get();
    taskDocs = results.docs;
    setState(() {

    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      drawer: drawer(),
      body: Center(
        child: Column(
         children: <Widget>[
           Expanded(
             child: ListView(
               children: [
                 (taskDocs!=null)?  taskDocs.map<Widget>((task) => Text(task["name"])).toList():Text("Loading"),
               ],
             ),
           )
         ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Creation()),
          );
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}






