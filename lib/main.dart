import 'package:directwp/firebase_options.dart';
import 'package:directwp/screens/about.dart';
import 'package:directwp/screens/help.dart';
import 'package:directwp/screens/history.dart';
import 'package:directwp/screens/tabScreen.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
/* Scrrens */
import 'package:directwp/screens/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.android);
  await FirebaseAnalytics.instance.logAppOpen();
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final inputBorder = BorderRadius.vertical(
    bottom: Radius.circular(10.0),
    top: Radius.circular(20.0),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Direct Chat',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderSide: BorderSide(width: 0.0, style: BorderStyle.none),
            borderRadius: const BorderRadius.all(
              const Radius.circular(5.0),
            ),
          ),
        ),
        buttonTheme: ButtonThemeData(
            buttonColor: Colors.teal,
            padding: EdgeInsets.symmetric(vertical: 15.0),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
      ),
      initialRoute: '/',
      routes: {
        TabScreen.routeName: (ctx) => TabScreen(),
        MyHomePage.routeName: (ctx) => MyHomePage(),
        HistoryScreen.routeName: (ctx) => HistoryScreen(),
        HelpScreen.routeName: (ctx) => HelpScreen(),
        AboutScreen.routeName: (ctx) => AboutScreen()
      },
    );
  }
}
