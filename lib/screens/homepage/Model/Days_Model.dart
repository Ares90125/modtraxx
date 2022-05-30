class Days_Model{
  int? Id;
  String? Day;
  int? value;
  Days_Model({this.Id,this.Day,this.value});
  factory Days_Model.fromMap(Map<String, dynamic> json) => Days_Model(
    Id: json["id"],
    Day: json["day"],
    value: json["value"],
  );
  Map<String, dynamic> toMap() => {
    "id": Id,
    "day": Day,
    "value":value,
    // "daily_time": daily_time,
    // "isPending": isPending,
  };
}