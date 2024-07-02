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
  List<QueryDocumentSnapshot<Task>> taskItems = [];
  bool hasError = false;

  @override
  void initState() {
    super.initState();
    getTasks();
  }

  void getTasks() async {
    try {
      CollectionReference<Task> tasksCollection = getTasksCollection();
      QuerySnapshot<Task> results = await tasksCollection.get();
      setState(() {
        taskItems = results.docs;
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
            ? CircularProgressIndicator()
            : ListView.builder(
          itemCount: taskItems.length,
          itemBuilder: (context, index) {
            Task task = taskItems[index].data();
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Detail(
                      task: taskItems[index].data(),
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
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Creation()),
          );
        },
        tooltip: 'Add Task',
        child: const Icon(Icons.add),
      ),
    );
  }
}
