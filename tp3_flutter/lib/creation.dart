import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tp3_flutter/task.dart';

import 'Tiroir.dart';

class creation extends StatefulWidget {
  const creation({super.key});

  @override
  State<creation> createState() => _creationState();
}

class _creationState extends State<creation> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
home: tache(),
    );
  }
}

class tache extends StatefulWidget {
  const tache({super.key});
  @override
  State<tache> createState() => _tacheState();
}



class _tacheState extends State<tache> {

  static int taskCounter = 0;

  CollectionReference<Task> getTasksCollection  (){
    User? user = FirebaseAuth.instance.currentUser;

 return FirebaseFirestore.instance
      .collection("users")
      .doc(user!.uid)
      .collection(
      "tasks").withConverter<Task>(
     fromFirestore: (snapshot,_) => Task.fromJson(snapshot.data()!),
     toFirestore: (task,_) => task.toJson(),
 );
  }

  void addTask() {


CollectionReference tasksCollection = getTasksCollection();

Task task = Task(name: "dwdw", creationDate: DateTime(2021,01,01), endDate: DateTime(2021,01,01), percentage: 23);
tasksCollection.add({
      "name": "manger" + taskCounter.toString(),
      "Date": DateTime(2020, 01, 01),

    });

  }
  var taskDocs;

  void getTask() async {

    CollectionReference tasksCollection = getTasksCollection();
    Task task = Task(name: "dwdw", creationDate: DateTime(2021,01,01), endDate: DateTime(2021,01,01), percentage: 23);
    var results = await tasksCollection.get();
     taskDocs  = results.docs;

    setState(() {});
  }

  void modifyTask(String id) async {
    CollectionReference tasksCollection = getTasksCollection();
    Task task = Task(name: "dwdw", creationDate: DateTime(2021,01,01), endDate: DateTime(2021,01,01), percentage: 23);
    DocumentReference taskdoc = tasksCollection.doc(id);
    
    taskdoc.set({
      "name":"nager"
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme
            .of(context)
            .colorScheme
            .inversePrimary,

        title: Text("Creation"),
      ),
      drawer: Tiroir(),
      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () async {
                addTask();
              },
              child: Text("Ajouter une tache"),
            ),

            ElevatedButton(
              onPressed: () async {
                getTask();
              },
              child: Text("Recuperer une tache"),
            ),
          Expanded(child: ListView(
          children:
          (taskDocs!=null)?
          taskDocs.map<Widget>((task) => ElevatedButton(
            child:
              Text(task.data()!.name),
              onPressed: ()
              {
                  modifyTask(task.id);
                }
            ,
          )).toList()
              :[Text("Loading")],

           )
           )

          ],
        ),
      ),

    );
  }


}



