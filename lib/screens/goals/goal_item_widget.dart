import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
class GoalCardItemWidget extends StatefulWidget {
  final dynamic goalItem;
  const GoalCardItemWidget({Key? key, required this.goalItem}) : super(key: key);

  @override
  _GoalCardItemWidget createState() => _GoalCardItemWidget();
}

class _GoalCardItemWidget extends State<GoalCardItemWidget> {
  late bool isChecked;
  @override
  void initState() {
    widget.goalItem['completion'] == 'true'? isChecked = true : isChecked = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 8, 10, 0),
      child: Card(
        
        color: const Color(0xff181A21),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: const BorderSide(color: Color(0xff777777), width: 2.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 8),
                    child: Text(
                      widget.goalItem['goalName'],
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 8, 8, 8),
                    child: Row(
                      children: [
                        const Text(
                          'due by: ',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Color(0xff777777),
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          widget.goalItem['goalDate'],
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            color: Color(0xff07CE83),
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 12, 0),
              child: GFCheckbox(
                activeBgColor: const Color(0xff07CE83),
                size: GFSize.SMALL,
                type: GFCheckboxType.circle,
                activeIcon: const Icon(
                  Icons.check,
                  size: 20,
                  color: Colors.black,
                ),
                onChanged: (value) {
                  setState(() {
                    isChecked = value;
                  });
                },
                value: isChecked,
                inactiveIcon: null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
