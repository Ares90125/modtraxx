class Mood {
  late String url;
  late String rate;
  late String hours;
  late String note;
  late String date;
  late String time;

  Mood(
    this.url,
    this.rate,
    this.hours,
    this.note,
    this.date,
    this.time,
  );

  Mood.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    rate = json['rate'];
    hours = json['hours'];
    note = json['note'];
    date = json['date'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    data['rate'] = rate;
    data['hours'] = hours;
    data['note'] = note;
    data['date'] = date;
    data['time'] = time;

    return data;
  }
}
