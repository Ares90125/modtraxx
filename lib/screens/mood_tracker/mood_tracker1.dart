import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../util/colors.dart';

class MoodTracker1Screen extends StatefulWidget {
  const MoodTracker1Screen({Key? key}) : super(key: key);

  @override
  _MoodTracker1ScreenState createState() => _MoodTracker1ScreenState();
}

class _MoodTracker1ScreenState extends State<MoodTracker1Screen> {
  @override
  void initState() {
    initialUrl();
    super.initState();
  }

  void initialUrl() async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setString("url", json.encode('https://static.wixstatic.com/media/9039fb_cb978084fc164bfdabb7d76ac9d8ea01~mv2.gif'));
  }

  void saveUrl(String item) async{
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setString("url", json.encode(item));
  }

  @override
  Widget build(BuildContext context) {
    final List<String> imgList = [
      'https://static.wixstatic.com/media/9039fb_cb978084fc164bfdabb7d76ac9d8ea01~mv2.gif',
      'https://static.wixstatic.com/media/9039fb_2ef88631b02a409cab9fb04470a5235d~mv2.gif',
      'https://static.wixstatic.com/media/9039fb_b8eab96fcf69432a86fa59124025e3c1~mv2.gif',
      'https://static.wixstatic.com/media/9039fb_4db5297140824b979751865e00fa8f80~mv2.gif',
      'https://static.wixstatic.com/media/9039fb_1393085ffa61474d9742676c3ecd455f~mv2.gif',
      'https://static.wixstatic.com/media/9039fb_151b27cd07534070bca8829778a938b4~mv2.gif',
      'https://static.wixstatic.com/media/9039fb_48db0ca277224af5a2e911c6fdb76f0f~mv2.gif',
      'https://static.wixstatic.com/media/9039fb_947cf5e966004950abda1204fa0e8bd1~mv2.gif',
      'https://static.wixstatic.com/media/9039fb_0bff1eade5984373b98a8fdc4557e4b3~mv2.gif',
      'https://static.wixstatic.com/media/9039fb_2aa136a6cf2948bb95f86786e2e78c64~mv2.gif',
      'https://static.wixstatic.com/media/9039fb_93a439f6ad854808b10912f9618927ae~mv2.gif',
      'https://static.wixstatic.com/media/9039fb_dfda4362236d4664a2bffb056f7be00c~mv2.gif',
      'https://static.wixstatic.com/media/9039fb_dcf836f3d1824775aff4ff00bff30361~mv2.gif',
      'https://static.wixstatic.com/media/9039fb_30a8938b72544bcfa2638e7d5a95ba4a~mv2.gif',
      'https://static.wixstatic.com/media/9039fb_1f38b83b0b9d464c8664945b9718d39b~mv2.gif',
      'https://static.wixstatic.com/media/9039fb_bab6c163a5cc4a99b21d967f6deaf732~mv2.gif',
      'https://static.wixstatic.com/media/9039fb_905b5f862b2747a9b296bdeb1c77d1d3~mv2.gif',
      'https://static.wixstatic.com/media/9039fb_df7d62f04840412aa77ca5fc0cac383c~mv2.gif',
      'https://static.wixstatic.com/media/9039fb_8212b484718a453a8d27c98f118f0a06~mv2.gif',
      'https://static.wixstatic.com/media/9039fb_4a7ca2f03c624a35aaa6dfc5cbdaabeb~mv2.gif',
      'https://static.wixstatic.com/media/9039fb_f3f0ef7ad72d48c3ab783b5ab6e202f3~mv2.gif',
      'https://static.wixstatic.com/media/9039fb_eb3a11c4ae004564aa5262894330958f~mv2.gif',
      'https://static.wixstatic.com/media/9039fb_a4c13c70c0a14b078bc229cb69d97c0f~mv2.gif',
      'https://static.wixstatic.com/media/9039fb_1ab11830b12a407eb35ea31d6af148b9~mv2.gif',
      'https://static.wixstatic.com/media/9039fb_e873dd3e9c504b4eb59acbe6d35a6895~mv2.gif',
      'https://static.wixstatic.com/media/9039fb_028f43f12c8840d4b40449e3fe78ebc4~mv2.gif',
      'https://static.wixstatic.com/media/9039fb_0e0d88162cc4447189ccc498ea98701c~mv2.gif',
      'https://static.wixstatic.com/media/9039fb_a8797830b101474796f9029d66ed7e4c~mv2.gif',
      'https://static.wixstatic.com/media/9039fb_1b3ab5a6f23d4f97b1d8b87fa4c788d1~mv2.gif',
    ];

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
            child: Image.asset(
              'assets/images/zazzhands.gif',
              width: MediaQuery.of(context).size.width * 0.2,
              fit: BoxFit.fitWidth,
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: Text(
              'How are you today?',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Poppins',
                fontSize: 22,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: Text(
              'Choose Your Emoji',
              style: TextStyle(
                fontFamily: 'Poppins',
                color: secondaryColor,
                fontSize: 20,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          CarouselSlider(
            options: CarouselOptions(enableInfiniteScroll: false),
            items: imgList
                .map(
                  (item) => InkWell(
                    focusColor: Colors.grey,
                    hoverColor: Colors.white54,
                    highlightColor: Colors.grey,
                    onTap: () => {
                      saveUrl(item)
                    },
                    child: Center(
                      child: Image.network(
                        item,
                        fit: BoxFit.cover,
                        height: 150,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.arrow_left,
                color: Colors.white,
                size: 30,
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0),
                child: Text(
                  'Swipe & Tap',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              Icon(
                Icons.arrow_right,
                color: Colors.white,
                size: 30,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
            child: Container(
              height: 100,
              decoration: const BoxDecoration(),
              child: Image.asset(
                'assets/images/SwipeUp2.gif',
                width: 100,
                height: 100,
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
