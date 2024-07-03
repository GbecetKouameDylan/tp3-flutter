import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:tp3_flutter/drawer.dart';
import 'package:tp3_flutter/task.dart';
import 'lib_http.dart';

class Detail extends StatefulWidget {
  final Tasks task;
  final String id;
  const Detail({super.key, required this.task, required this.id});

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  String imageUrl = "";
  var taskDocs;

  void modifyTask(int percentage) async {
    CollectionReference<Tasks> tasksCollection = getTasksCollection();
    DocumentReference<Tasks> taskDoc = tasksCollection.doc(widget.id);

    Map<String, dynamic> updatedData = {
      "percentage": percentage
    };

    await taskDoc.update(updatedData);
  }


  void pickImage() async {
    // Check and request permission
    PermissionStatus status = await Permission.storage.status;

    if (!status.isGranted) {
      FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);
      if (result != null) {
        File file = File(result.files.single.path!);

        DocumentReference imageDoc = await FirebaseFirestore.instance.collection("images").add({
          "url": ""
        });

        Reference imageReference = FirebaseStorage.instance.ref(imageDoc.id + ".jpg");
        await imageReference.putFile(file);

        imageUrl = await imageReference.getDownloadURL();

        await imageDoc.update({
          "url": imageUrl
        });

        setState(() {
          // Update the UI with the new image URL
        });
      } else {
        print("No file selected");
      }
    } else {
      print("Permission denied");
    }
  }

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
              ElevatedButton(
                onPressed: () {
                  modifyTask(2);
                },
                child: Text("Change the percentage"),
              ),
              ElevatedButton(
                onPressed: () {
                  pickImage();
                },
                child: Text("Pick image"),
              ),
              (imageUrl != "") ? Image.network(imageUrl,width: 100,) : Text("No image")
            ],
          ),
        ),
      ),
    );
  }
}
