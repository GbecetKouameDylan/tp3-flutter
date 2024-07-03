// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tasks _$TasksFromJson(Map<String, dynamic> json) => Tasks(
      name: json['name'] as String,
      creationDate: DateTime.parse(json['creationDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      percentage: (json['percentage'] as num).toInt(),
    );

Map<String, dynamic> _$TasksToJson(Tasks instance) => <String, dynamic>{
      'name': instance.name,
      'creationDate': instance.creationDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
      'percentage': instance.percentage,
    };
