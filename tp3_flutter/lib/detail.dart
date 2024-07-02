import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tp3_flutter/drawer.dart';
import 'package:tp3_flutter/task.dart';

import 'lib_http.dart';

class Detail extends StatefulWidget {

  final Task task;
  const Detail({super.key, required this.task});

  @override
  State<Detail> createState() => _DetailState();
}

void modifyTask(String name, DateTime date, int percentage) async {
  CollectionReference<Task> tasksCollection = getTasksCollection();
  DocumentReference<Task> taskdoc = tasksCollection.doc(taskDocs.id);

  Task task = Task(name: name, creationDate: DateTime.now(), endDate: date, percentage: percentage);

  taskdoc.set(task);
}

class _DetailState extends State<Detail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail"),
      ),
      drawer: drawer(),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              Text("${widget.task.name}"),

              Text("${widget.task.creationDate}"),

              Text("${widget.task.endDate}"),

              Text("${widget.task.percentage}"),
ElevatedButton(onPressed:()  {modifyTask(widget.task.name,widget.task.endDate,widget.task.percentage);}
    , child: Text("Change the percentage"))

            ],
          ),
        ),
      ),
    );
  }
}

