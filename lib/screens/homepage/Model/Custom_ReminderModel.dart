class Custom_Reminder_Model {
  int? id;
  String? title;
  String? Day;
  DateTime? time;
  bool? isPending;
  Custom_Reminder_Model(
      {this.id, this.title, this.Day, this.time, this.isPending});
  factory Custom_Reminder_Model.fromMap(Map<String, dynamic> json) =>
      Custom_Reminder_Model(
        id: json["id"],
        title: json["title"],
        Day: json["day"],
        isPending: json["isPending"] == 1,
        time: DateTime.parse(json["time"]),
      );
  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "day": Day,
        "isPending": isPending,
        "time": time?.toIso8601String(),
      };
}
