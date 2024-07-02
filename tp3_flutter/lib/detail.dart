import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tp3_flutter/drawer.dart';
import 'package:tp3_flutter/task.dart';

class Detail extends StatefulWidget {

  final Task task;
  const Detail({super.key, required this.task});

  @override
  State<Detail> createState() => _DetailState();
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
            ],
          ),
        ),
      ),
    );
  }
}

