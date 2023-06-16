import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DailyAim extends StatefulWidget {
  @override
  _DailyAimState createState() => _DailyAimState();
}

class _DailyAimState extends State<DailyAim> {
  final User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Daily Aim & Results'),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(user!.email)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }

          var userData = snapshot.data!.data() as Map<String, dynamic>;
          var userAim = userData['aim'];
          var calorieText = '';
          var instructionText = '';
          var targetCalorie = 0;

          if (userAim == 'loseweight') {
            calorieText = 'The amount of calorie per day = 1500 cal';
            instructionText =
            'Do running\nSwimming\nIncrease your water intake';
            targetCalorie = 1500;
          } else if (userAim == 'gainweight') {
            calorieText = 'The amount of calorie per day = 2500 cal';
            instructionText = 'Weightlifting exercises.';
            targetCalorie = 2500;
          }

          var currentCalorie = userData['calorie'] ?? 0;
          var progressPercentage = (currentCalorie / targetCalorie).clamp(0.0, 1.0);

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Your Daily Aim',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.orangeAccent[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.all(20),
                  child: Text(
                    calorieText,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.purpleAccent[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.all(20),
                  child: Text(
                    instructionText,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Progress',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                LinearProgressIndicator(
                  value: progressPercentage,
                  backgroundColor: Colors.green[100],
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                  minHeight: 30,
                ),
                SizedBox(height: 10),
                Text(
                  '$currentCalorie / $targetCalorie',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 30),
                Text(
                  'You are very close to the \ncompletion of the target! \n              Good Job!',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
