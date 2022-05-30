import 'package:flutter/material.dart';
import 'package:moodtraxx/model/mood_model.dart';

class MoodItem extends StatefulWidget {
  final dynamic logItem;
  const MoodItem({Key? key, required this.logItem}) : super(key: key);

  @override
  _MoodItemState createState() => _MoodItemState();
}

class _MoodItemState extends State<MoodItem> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16.0),
                      child: Image.network(
                        Mood.fromJson(widget.logItem).url.replaceAll('"', ''),
                        width: MediaQuery.of(context).size.width * 0.15,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                  const Icon(
                    Icons.notes_rounded,
                    size: 40,
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text("Date: "),
                      Text(Mood.fromJson(widget.logItem).date),
                      const SizedBox(width: 10),
                      const Text("Time: "),
                      Text(Mood.fromJson(widget.logItem).time),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Row(
                      children: [
                        const Text(
                          "MOOD #: ",
                          style: TextStyle(
                            color: Color(0xff1A1351),
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          Mood.fromJson(widget.logItem)
                              .rate
                              .replaceAll('"', ''),
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            "SLEEP HOURS: ",
                            style: TextStyle(
                              color: Color(0xff1A1351),
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Text(
                          Mood.fromJson(widget.logItem)
                              .hours
                              .replaceAll('"', ''),
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                    child: Text('Notes:'),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.65,
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        Mood.fromJson(widget.logItem).note.replaceAll('"', ''),
                        style: const TextStyle(),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
