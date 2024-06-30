import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

  CollectionReference getTasksCollection  (){
    User? user = FirebaseAuth.instance.currentUser;

 return FirebaseFirestore.instance
      .collection("users")
      .doc(user!.uid)
      .collection(
      "tasks");
  }

  void addTask() {

CollectionReference tasksCollection = getTasksCollection();

    tasksCollection.add({
      "name": "manger" + taskCounter.toString(),
      "Date": DateTime(2020, 01, 01),

    });

  }
  var taskDocs;

  void getTask() async {
    CollectionReference tasksCollection = getTasksCollection();
    var results = await tasksCollection.get();
     taskDocs  = results.docs;
    var task = taskDocs[0].data();
    print(task);
    setState(() {});
  }

  void modifyTask(String id) async {
    CollectionReference tasksCollection = getTasksCollection();
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
              Text(task["name"]),
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



