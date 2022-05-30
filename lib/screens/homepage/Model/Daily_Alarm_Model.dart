import 'package:flutter/material.dart';

class Daily_Alarm_Model{
  int? id;
  String? title;
  // String? daily_time;
  // bool? isPending;
  Daily_Alarm_Model({this.id,this.title});
  factory Daily_Alarm_Model.fromMap(Map<String, dynamic> json) => Daily_Alarm_Model(
    id: json["id"],
    title: json["title"],
    // daily_time: json["daily_time"],
    // isPending: json["isPending"],

  );
  Map<String, dynamic> toMap() => {
    "id": id,
    "title": title,
    // "daily_time": daily_time,
    // "isPending": isPending,
  };
}