import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import './goal_detail_page.dart';
import './goal_item_widget.dart';
import './create_goal_widget.dart';
import '../homepage/home_page.dart';

class MyGoalScreen extends StatefulWidget {
  const MyGoalScreen({Key? key}) : super(key: key);

  @override
  _MyGoalScreenState createState() => _MyGoalScreenState();
}

class _MyGoalScreenState extends State<MyGoalScreen> {
  var goalList = [];
  var reversedGoalData = [];

  @override
  void initState() {
    getGoalData();
    super.initState();
  }

  void getGoalData() async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    if (_prefs.getString('goals') == null) {
      setState(() {
        goalList = [];
      });
    } else {
      setState(() {
        goalList = json.decode(_prefs.getString('goals') ?? '');
        reversedGoalData = List.from(goalList.reversed);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Color(0xff4B39EF)),
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
          child: Image.asset(
            'assets/images/MoodTraxx-Logo-Light.png',
            width: 70,
            height: 70,
            fit: BoxFit.fitWidth,
          ),
        ),
        leading: InkWell(
          onTap: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const HomePageScreen(),
              ),
            );
          },
          child: const Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 24,
          ),
        ),
        centerTitle: true,
        elevation: 4,
      ),
      backgroundColor: Colors.black,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await showModalBottomSheet(
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            context: context,
            builder: (context) {
              return Padding(
                padding: MediaQuery.of(context).viewInsets,
                child: const SizedBox(
                  height: 410,
                  child: CreateGoalWidget(),
                ),
              );
            },
          );
        },
        elevation: 8,
        backgroundColor: const Color(0xFF1D1D1D),
        child: const Icon(
          Icons.add_rounded,
          color: Colors.white,
          size: 30,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 80,
                child: Image.asset(
                  'assets/images/MyGoals-Header.jpg',
                  width: 100,
                  height: 100,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 12, 16, 0),
            child: Text(
              'Goal Schedule:',
              style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Color(0xff95A1AC),
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(
            flex: 5,
            child: ListView.builder(
              itemCount: reversedGoalData.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GoalDetailPage(index: index, goalItem: reversedGoalData[index])
                      ),
                    );
                  },
                  child: GoalCardItemWidget(goalItem: reversedGoalData[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
