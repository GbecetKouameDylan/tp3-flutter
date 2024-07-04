import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tp3_flutter/detail.dart';
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
  List<QueryDocumentSnapshot<Tasks>> taskItems = [];
  bool hasError = false;

  @override
  void initState() {
    super.initState();
    getTasks();
  }
var taskDocs;
  void getTasks() async {
    try {
      CollectionReference<Tasks> tasksCollection = getTasksCollection();
      QuerySnapshot<Tasks> results = await tasksCollection.get();
      setState(() {
        taskItems = results.docs;
        taskDocs = results.docs;
      });
    } catch (e) {
      setState(() {
        hasError = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      drawer: drawer(),
      body: Center(
        child: hasError
            ? Text('Error loading tasks')
            : taskItems.isEmpty
            ? ElevatedButton(onPressed:()
            {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                  builder: (context) => Creation()
              ),
              );
            },
            child: Text("No task found add one"))
            :
    ListView.builder(
          itemCount: taskItems.length,
          itemBuilder: (context, index) {
            Tasks task = taskItems[index].data();
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Detail(
                      task: taskItems[index].data(),
                      id:taskItems[index].id
                    ),
                  ),
                );
              },
              child: Card(
                child: ListTile(
                  title: Text(task.name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      (task.url != "") ? Image.network(task.url,width: 30,) : Text("No image"),

                      Text(
                          ' ${task.creationDate}'),
                      Text(
                          ' ${task.endDate}'),
                      Text(
                          ' ${task.percentage}%'),
                    ],
                  ),
                ),
              ),
            );

          },
        )
      ),

    );

  }
}
