import 'package:shared_preferences/shared_preferences.dart';

class Switch_Servies{
  //Daily switch
  Future<bool> Daily_saveSwitchState(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("Daily", value);
    print('Switch Value saved $value');
    return prefs.setBool("Daily", value);
  }
  Future<bool> Daily_getSwitchState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isSwitchedFT = prefs.getBool("Daily");
    print(isSwitchedFT);

    return isSwitchedFT!;
  }
  Future<bool> saveSwitchState(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("switchState", value);
    print('Switch Value saved $value');
    return prefs.setBool("switchState", value);
  }
  //****************************************
  //Weekly Switch
  Future<bool> Weekly_saveSwitchState(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("Weekly", value);
    print('Switch Value saved $value');
    return prefs.setBool("Weekly", value);
  }
  Future<bool> Weekly_getSwitchState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isSwitchedFT = prefs.getBool("Weekly");
    print(isSwitchedFT);

    return isSwitchedFT!;
  }
  Future<bool> getSwitchState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isSwitchedFT = prefs.getBool("switchState");
    print(isSwitchedFT);

    return isSwitchedFT!;
  }
//*****************************************
}