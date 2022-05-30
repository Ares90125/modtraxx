class weekly_Alarm_Model {
  int? id;
  String? title;
  DateTime? alarmDateTime;
  bool? isPending;
  String? day;

  weekly_Alarm_Model(
      {this.id, this.title, this.alarmDateTime, this.isPending, this.day});

  factory weekly_Alarm_Model.fromMap(Map<String, dynamic> json) =>
      weekly_Alarm_Model(
        id: json["id"],
        title: json["title"],
        alarmDateTime: DateTime.parse(json["weeksDateTime"]),
        isPending: json["isPending"] == 1,
        day: json["day"],
      );
  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "weeksDateTime": alarmDateTime?.toIso8601String(),
        "isPending": isPending,
        "day": day,
      };
}
