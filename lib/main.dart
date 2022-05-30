import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:moodtraxx/screens/homepage/Model/alarm_info.dart';
import 'package:moodtraxx/screens/homepage/Reminder_Screen.dart';
import 'package:moodtraxx/screens/homepage/Service/NotificationService.dart';
import 'package:moodtraxx/screens/homepage/helper/alarm_helper.dart';
import 'package:moodtraxx/screens/homepage/home_page.dart';
import 'package:moodtraxx/screens/onboarding/onboarding.dart';
import 'package:moodtraxx/service/authentication.dart';
import 'package:provider/provider.dart';

Future<void> _messageHandler(RemoteMessage message) async {
  print('background message ${message.notification!.body}');
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();
  var initializationSettingsAndroid =
      AndroidInitializationSettings('mood_tracker');
  var initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification:
          (int? id, String? title, String? body, String? payload) async {});
  var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (String? payload) async {
    if (payload != null) {
      try {
        await Navigator.push(MyApp.navigatorKey.currentState!.context,
            new MaterialPageRoute(builder: (context) => HomePageScreen()));
      } catch (e) {
        print(e.toString());
      }
    }
  });

  await Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage(_messageHandler);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static final navigatorKey = new GlobalKey<NavigatorState>();
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticationHelper>(
          create: (_) => AuthenticationHelper(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) => context.read<AuthenticationHelper>().authState,
          initialData: null,
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        title: 'Mood Traxx',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        //home:const Reminder_Screen(),
        home: const MyHomePage(title: 'Mood Traxx'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    getMessage(context);
  }

  void getMessage(context) async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print("message recieved");
      if (message.notification != null) {
        var data = message.data;
        print(data);
        // print(message.notification!.body);
        // print(message.data.values);
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Notification"),
                content: Text(message.notification!.body!),
                actions: [
                  TextButton(
                    child: const Text("Ok"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              );
            });
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      print('Message clicked!');
      if (message.notification != null) {}
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Authenticate();
  }
}

class Authenticate extends StatelessWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();

    if (firebaseUser != null) {
      return const HomePageScreen();
    }
    return const OnboardingScreen();
  }
}
