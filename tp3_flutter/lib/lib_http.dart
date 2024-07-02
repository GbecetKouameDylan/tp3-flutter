import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tp3_flutter/task.dart';

CollectionReference<Task> getTasksCollection() {
  User? user = FirebaseAuth.instance.currentUser;

  return FirebaseFirestore.instance
      .collection("users")
      .doc(user!.uid)
      .collection("tasks")
      .withConverter<Task>(
    fromFirestore: (snapshot, _) => Task.fromJson(snapshot.data()!),
    toFirestore: (task, _) => task.toJson(),
  );
}
var taskDocs;

void addTask(String nom, DateTime date) {
  CollectionReference<Task> tasksCollection = getTasksCollection();
  Task task = Task(name: nom, creationDate: DateTime.now(), endDate: date, percentage: 23);

  tasksCollection.add(task).then((value) {
    print("Task Added");
  }).catchError((error) {
    print("Failed to add task: $error");
  });
}


