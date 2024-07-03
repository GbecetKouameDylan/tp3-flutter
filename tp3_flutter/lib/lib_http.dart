import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tp3_flutter/task.dart';

CollectionReference<Tasks> getTasksCollection() {
  User? user = FirebaseAuth.instance.currentUser;

  return FirebaseFirestore.instance
      .collection("users")
      .doc(user!.uid)
      .collection("tasks")
      .withConverter<Tasks>(
    fromFirestore: (snapshot, _) => Tasks.fromJson(snapshot.data()!),
    toFirestore: (task, _) => task.toJson(),
  );
}


void addTask(String nom, DateTime date) {
  CollectionReference<Tasks> tasksCollection = getTasksCollection();

  Tasks task = Tasks(name: nom, creationDate: DateTime.now(), endDate: date, percentage: 23 );

  tasksCollection.add(task).then((value) {
    print("Task Added");
  }).catchError((error) {
    print("Failed to add task: $error");
  });
}




