import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ChartScreen extends StatefulWidget {
  final List logList;
  const ChartScreen({Key? key, required this.logList}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ChartScreenState();
}

class ChartScreenState extends State<ChartScreen> {
  List<double> averageRateList = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0];
  List<int> averageSleepHoursList = [0, 0, 0, 0, 0, 0, 0];
  double totalRateAvr = 0.0;
  double totalHourAvr = 0.0;
  final Color leftBarColor = const Color(0xff3BDAFF);
  final Color rightBarColor = const Color(0xff0073FF);
  final double width = 7;
  DateTime now = DateTime.now();

  late List<BarChartGroupData> rawBarGroups;
  late List<BarChartGroupData> showingBarGroups;

  int touchedGroupIndex = -1;

  @override
  void initState() {
    super.initState();
    print(widget.logList);
    saveAverageRateAndHoursPerDay(widget.logList);
    final barGroup1 = makeGroupData(
        0,
        averageRateList[6].isNaN ? 0 : averageRateList[6] * 10,
        averageSleepHoursList[6].isNaN ? 0 : averageSleepHoursList[6] * 10);
    final barGroup2 = makeGroupData(
        1,
        averageRateList[5].isNaN ? 0 : averageRateList[5] * 10,
        averageSleepHoursList[5].isNaN ? 0 : averageSleepHoursList[5] * 10);
    final barGroup3 = makeGroupData(
        2,
        averageRateList[4].isNaN ? 0 : averageRateList[4] * 10,
        averageSleepHoursList[4].isNaN ? 0 : averageSleepHoursList[4] * 10);
    final barGroup4 = makeGroupData(
        3,
        averageRateList[3].isNaN ? 0 : averageRateList[3] * 10,
        averageSleepHoursList[3].isNaN ? 0 : averageSleepHoursList[3] * 10);
    final barGroup5 = makeGroupData(
        4,
        averageRateList[2].isNaN ? 0 : averageRateList[2] * 10,
        averageSleepHoursList[2].isNaN ? 0 : averageSleepHoursList[2] * 10);
    final barGroup6 = makeGroupData(
        5,
        averageRateList[1].isNaN ? 0 : averageRateList[1] * 10,
        averageSleepHoursList[1].isNaN ? 0 : averageSleepHoursList[1] * 10);
    final barGroup7 = makeGroupData(
        6,
        averageRateList[0].isNaN ? 0 : averageRateList[0] * 10,
        averageSleepHoursList[0].isNaN ? 0 : averageSleepHoursList[0] * 10);

    final items = [
      barGroup1,
      barGroup2,
      barGroup3,
      barGroup4,
      barGroup5,
      barGroup6,
      barGroup7,
    ];

    rawBarGroups = items;

    showingBarGroups = rawBarGroups;
  }

  void saveAverageRateAndHoursPerDay(List data) {
    List<double> sumRates = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0];
    List<int> sumHours = [0, 0, 0, 0, 0, 0, 0];
    List<int> count = [0, 0, 0, 0, 0, 0, 0];
    int maxHours = 0;
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final now = DateTime.parse(formatter.format(DateTime.now()));
    for (var i = 0; i < data.length; i++) {
      var moodDate = DateFormat("MM/dd/yyyy").parse(data[i]['date']);
      if (moodDate == now) {
        count[0]++;
        sumRates[0] += double.parse(json.decode(data[i]['rate']));
        maxHours = int.parse(json.decode(data[i]['hours']));
        if (maxHours > 10) maxHours = 10;
        if (sumHours[0] < maxHours) sumHours[0] = maxHours;
      }
      if (moodDate == now.add(const Duration(days: -1))) {
        count[1]++;
        sumRates[1] += double.parse(json.decode(data[i]['rate']));
        maxHours = int.parse(json.decode(data[i]['hours']));
        if (maxHours > 10) maxHours = 10;
        if (sumHours[1] < maxHours) sumHours[1] = maxHours;
      }
      if (moodDate == now.add(const Duration(days: -2))) {
        count[2]++;
        sumRates[2] += double.parse(json.decode(data[i]['rate']));
        maxHours = int.parse(json.decode(data[i]['hours']));
        if (maxHours > 10) maxHours = 10;
        if (sumHours[2] < maxHours) sumHours[2] = maxHours;
      }
      if (moodDate == now.add(const Duration(days: -3))) {
        count[3]++;
        sumRates[3] += double.parse(json.decode(data[i]['rate']));
        maxHours = int.parse(json.decode(data[i]['hours']));
        if (maxHours > 10) maxHours = 10;
        if (sumHours[3] < maxHours) sumHours[3] = maxHours;
      }
      if (moodDate == now.add(const Duration(days: -4))) {
        count[4]++;
        sumRates[4] += double.parse(json.decode(data[i]['rate']));
        maxHours = int.parse(json.decode(data[i]['hours']));
        if (maxHours > 10) maxHours = 10;
        if (sumHours[4] < maxHours) sumHours[4] = maxHours;
      }
      if (moodDate == now.add(const Duration(days: -5))) {
        count[5]++;
        sumRates[5] += double.parse(json.decode(data[i]['rate']));
        maxHours = int.parse(json.decode(data[i]['hours']));
        if (maxHours > 10) maxHours = 10;
        if (sumHours[5] < maxHours) sumHours[5] = maxHours;
      }
      if (moodDate == now.add(const Duration(days: -6))) {
        count[6]++;
        sumRates[6] += double.parse(json.decode(data[i]['rate']));
        maxHours = int.parse(json.decode(data[i]['hours']));
        if (maxHours > 10) maxHours = 10;
        if (sumHours[6] < maxHours) sumHours[6] = maxHours;
      }
    }
    for (var i = 0; i < count.length; i++) {
      averageRateList[i] =
          double.parse((sumRates[i] / count[i]).toStringAsFixed(2));
      averageSleepHoursList[i] = sumHours[i];
    }
    // print(averageRateList);
    // print(averageSleepHoursList);
    var tempCount1 = 0;
    var tempCount2 = 0;
    for (var i = 0; i < 6; i++) {
      if (!averageRateList[i].isNaN) {
        totalRateAvr += averageRateList[i];
        tempCount1++;
      }
      if (averageSleepHoursList[i] != 0) {
        totalHourAvr += averageSleepHoursList[i];
        tempCount2++;
      }
    }
    totalRateAvr = double.parse((totalRateAvr / tempCount1).toStringAsFixed(2));
    totalHourAvr = double.parse((totalHourAvr / tempCount2).toStringAsFixed(2));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Color(0xff4B39EF)),
        automaticallyImplyLeading: true,
        title: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
          child: Image.asset(
            'assets/images/MoodTraxx-Logo-Light.png',
            width: 70,
            height: 70,
            fit: BoxFit.fitWidth,
          ),
        ),
        centerTitle: true,
        elevation: 4,
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          AspectRatio(
            aspectRatio: 0.85,
            child: Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                  side: const BorderSide(color: Color(0xffB4B4B4))),
              color: const Color(0xff141414),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          'Week At A Glance',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    IntrinsicHeight(
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: const Color(0xff333333),
                                    borderRadius: BorderRadius.circular(50),
                                    border: Border.all(
                                      color: const Color(0xffB5B5B5),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.asset(
                                        'assets/icons/thumbs-up.png',
                                        height: 30.0,
                                        width: 30.0,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Text(
                                    totalRateAvr.toString(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(top: 8),
                                  child: Text(
                                    'Average Daily',
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      color: Color(0xff888888),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(bottom: 8),
                                  child: Text(
                                    'Mood Rate',
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      color: Color(0xff888888),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 35, bottom: 35),
                            child: VerticalDivider(
                              thickness: 1,
                              width: 20,
                              color: Color(0xff444444),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: const Color(0xff333333),
                                    borderRadius: BorderRadius.circular(50),
                                    border: Border.all(
                                      color: const Color(0xffB5B5B5),
                                    ),
                                  ),
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(8, 8, 8, 8),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.asset(
                                        'assets/icons/sleeping_animation.gif',
                                        height: 30.0,
                                        width: 30.0,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Text(
                                    totalHourAvr.toString(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(top: 8),
                                  child: Text(
                                    'Average Daily',
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      color: Color(0xff888888),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(bottom: 8),
                                  child: Text(
                                    'Sleep Hours',
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      color: Color(0xff888888),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: const [
                            Icon(
                              Icons.circle_outlined,
                              color: Color(0xff3BDAFF),
                              size: 16,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Text(
                                'Mood Rate',
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: Color(0xff888888),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: const [
                            Icon(
                              Icons.circle_outlined,
                              color: Color(0xff3BDAFF),
                              size: 16,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Text(
                                'Sleep Hours',
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: Color(0xff0073FF),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image.asset(
                                  'assets/icons/Mad.png',
                                  height: 20.0,
                                  width: 20.0,
                                  fit: BoxFit.fill,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Image.asset(
                                    'assets/icons/Glad.png',
                                    height: 20.0,
                                    width: 20.0,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  child: Image.asset(
                                    'assets/icons/Sad.png',
                                    height: 20.0,
                                    width: 20.0,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: BarChart(
                              BarChartData(
                                maxY: 100,
                                barTouchData: BarTouchData(
                                    touchTooltipData: BarTouchTooltipData(
                                      tooltipBgColor: Colors.grey,
                                      getTooltipItem: (_a, _b, _c, _d) => null,
                                    ),
                                    touchCallback:
                                        (FlTouchEvent event, response) {
                                      if (response == null ||
                                          response.spot == null) {
                                        setState(() {
                                          touchedGroupIndex = -1;
                                          showingBarGroups =
                                              List.of(rawBarGroups);
                                        });
                                        return;
                                      }

                                      touchedGroupIndex =
                                          response.spot!.touchedBarGroupIndex;

                                      setState(() {
                                        if (!event
                                            .isInterestedForInteractions) {
                                          touchedGroupIndex = -1;
                                          showingBarGroups =
                                              List.of(rawBarGroups);
                                          return;
                                        }
                                        showingBarGroups =
                                            List.of(rawBarGroups);
                                        if (touchedGroupIndex != -1) {
                                          var sum = 0.0;
                                          for (var rod in showingBarGroups[
                                                  touchedGroupIndex]
                                              .barRods) {
                                            sum += rod.y;
                                          }
                                          final avg = sum /
                                              showingBarGroups[
                                                      touchedGroupIndex]
                                                  .barRods
                                                  .length;

                                          showingBarGroups[touchedGroupIndex] =
                                              showingBarGroups[
                                                      touchedGroupIndex]
                                                  .copyWith(
                                            barRods: showingBarGroups[
                                                    touchedGroupIndex]
                                                .barRods
                                                .map((rod) {
                                              return rod.copyWith(y: avg);
                                            }).toList(),
                                          );
                                        }
                                      });
                                    }),
                                titlesData: FlTitlesData(
                                  show: true,
                                  rightTitles: SideTitles(showTitles: false),
                                  topTitles: SideTitles(showTitles: false),
                                  bottomTitles: SideTitles(
                                    showTitles: true,
                                    getTextStyles: (context, value) =>
                                        const TextStyle(
                                            color: Color(0xff666666),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14),
                                    margin: 20,
                                    getTitles: (double value) {
                                      switch (value.toInt()) {
                                        case 0:
                                          return DateFormat("dd")
                                              .format(now.add(
                                                  const Duration(days: -6)))
                                              .toString();
                                        case 1:
                                          return DateFormat("dd")
                                              .format(now.add(
                                                  const Duration(days: -5)))
                                              .toString();
                                        case 2:
                                          return DateFormat("dd")
                                              .format(now.add(
                                                  const Duration(days: -4)))
                                              .toString();
                                        case 3:
                                          return DateFormat("dd")
                                              .format(now.add(
                                                  const Duration(days: -3)))
                                              .toString();
                                        case 4:
                                          return DateFormat("dd")
                                              .format(now.add(
                                                  const Duration(days: -2)))
                                              .toString();
                                        case 5:
                                          return DateFormat("dd")
                                              .format(now.add(
                                                  const Duration(days: -1)))
                                              .toString();
                                        case 6:
                                          return DateFormat("MM/dd")
                                              .format(DateTime.now())
                                              .toString();
                                        default:
                                          return '';
                                      }
                                    },
                                  ),
                                  leftTitles: SideTitles(
                                    showTitles: true,
                                    getTextStyles: (context, value) =>
                                        const TextStyle(
                                            color: Color(0xff666666),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14),
                                    margin: 8,
                                    reservedSize: 28,
                                    interval: 1,
                                    getTitles: (value) {
                                      if (value == 0) {
                                        return '0';
                                      } else if (value == 25) {
                                        return '2.5';
                                      } else if (value == 50) {
                                        return '5';
                                      } else if (value == 75) {
                                        return '7.5';
                                      } else if (value == 100) {
                                        return '10';
                                      } else {
                                        return '';
                                      }
                                    },
                                  ),
                                ),
                                borderData: FlBorderData(
                                  show: true,
                                  border: const Border(
                                    left: BorderSide(
                                        width: 1.0, color: Colors.white60),
                                    bottom: BorderSide(
                                        width: 1.0, color: Colors.white60),
                                  ),
                                ),
                                barGroups: showingBarGroups,
                                gridData: FlGridData(
                                    drawVerticalLine: false,
                                    drawHorizontalLine: true,
                                    horizontalInterval: 25),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  BarChartGroupData makeGroupData(int x, double y1, double y2) {
    return BarChartGroupData(barsSpace: 4, x: x, barRods: [
      BarChartRodData(
        y: y1,
        colors: [leftBarColor],
        width: width,
      ),
      BarChartRodData(
        y: y2,
        colors: [rightBarColor],
        width: width,
      ),
    ]);
  }
}
