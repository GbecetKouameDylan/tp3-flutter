import 'package:cloud_firestore/cloud_firestore.dart';
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

  static int

  void addTask() {
    CollectionReference tasksCollection = FirebaseFirestore.instance.collection(
        "tasks");
    tasksCollection.add({
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

          ],
        ),
      ),

    );
  }
}


