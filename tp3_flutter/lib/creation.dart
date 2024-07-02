import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tp3_flutter/task.dart';

import 'drawer.dart';
import 'lib_http.dart';

class Creation extends StatefulWidget {
  const Creation({super.key});

  @override
  State<Creation> createState() => _CreationState();
}

class _CreationState extends State<Creation> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Tache(),
    );
  }
}

class Tache extends StatefulWidget {
  const Tache({super.key});

  @override
  State<Tache> createState() => _TacheState();
}

class _TacheState extends State<Tache> {
  final _nameController = TextEditingController();
  DateTime? _selectedDate;







  void modifyTask(String id) async {
    CollectionReference<Task> tasksCollection = getTasksCollection();
    DocumentReference taskdoc = tasksCollection.doc(id);
    taskdoc.set({
      "name": "nager",
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Creation"),
      ),
      drawer: drawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Task name"),
            TextFormField(
              controller: _nameController,
            ),
            Text("Task end date"),
            Text(
              _selectedDate != null
                  ? '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'
                  : "Choose",
            ),
            IconButton(
              icon: Icon(Icons.calendar_today),
              onPressed: () => _selectDate(context),
            ),
            ElevatedButton(
              onPressed: () {
                if (_nameController.text.isNotEmpty && _selectedDate != null) {
                  addTask(_nameController.text, _selectedDate!);
                } else {
                  // Show an error message if the name or date is not provided
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Please enter a task name and select a date.'),
                    ),
                  );
                }
              },
              child: Text("Add a task"),
            ),
          ],
        ),
      ),
    );
  }
}
