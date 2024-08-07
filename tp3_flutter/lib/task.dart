
import 'package:json_annotation/json_annotation.dart';

part 'task.g.dart';

@JsonSerializable()
class Tasks
{
String url;
  String name;
  DateTime creationDate;
  DateTime endDate;
  int percentage;

  Tasks({required this.name ,required this.creationDate , required this.endDate, required this.percentage,required this.url });

  factory Tasks.fromJson(Map<String, dynamic> json) => _$TasksFromJson(json);
  Map<String, dynamic> toJson() => _$TasksToJson(this);
}