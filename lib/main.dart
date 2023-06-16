import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:nutrition_tracker_app/MealList.dart';
import 'package:flutter/material.dart';
import 'HomeScreen.dart';
import 'UserSettings.dart';
import 'DailyAim.dart';
import 'package:nutrition_tracker_app/MedicalRecord.dart';
import 'package:nutrition_tracker_app/LoginScreen.dart';
import 'package:nutrition_tracker_app/SignupScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "/MealList": (context) => MealListPage(),
        "/LoginScreen": (context) => LoginScreen(),
        "/HomeScreen": (context) => HomeScreen(),
        "/UserSettings": (context) => UserSettings(),
        "/MedicalRecord": (context) => MedicalRecord(),
        "/DailyAim": (context) => DailyAim(),
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginScreen(),
    );
  }
}
