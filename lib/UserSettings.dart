import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserSettings extends StatefulWidget {
  const UserSettings({Key? key}) : super(key: key);

  @override
  _UserSettingsState createState() => _UserSettingsState();
}

class _UserSettingsState extends State<UserSettings> {
  final TextEditingController ageController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController bmiController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Settings'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            children: [
              TextFormField(
                controller: ageController,
                decoration: InputDecoration(
                  labelText: 'Age',
                ),
              ),
              TextFormField(
                controller: heightController,
                decoration: InputDecoration(
                  labelText: 'Height',
                ),
              ),
              TextFormField(
                controller: weightController,
                decoration: InputDecoration(
                  labelText: 'Weight',
                ),
              ),
              TextFormField(
                controller: bmiController,
                decoration: InputDecoration(
                  labelText: 'BMI',
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                child: Text('Calculate BMI'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.pinkAccent[100],
                  fixedSize: Size(150, 50),
                ),
                onPressed: () {
                  calculateBMI();
                },
              ),
              SizedBox(height: 40),
              ElevatedButton(
                child: Text('Save'),
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(200, 50),
                ),
                onPressed: () {
                  String age = ageController.text;
                  String height = heightController.text;
                  String weight = weightController.text;
                  String bmi = bmiController.text;

                  updateUserData(age, height, weight, bmi);
                  Navigator.pushNamed(context, '/HomeScreen');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void calculateBMI() {
    double height = double.tryParse(heightController.text) ?? 0;
    double weight = double.tryParse(weightController.text) ?? 0;

    if (height > 0 && weight > 0) {
      double bmi = weight / ((height / 100) * (height / 100));
      bmiController.text = bmi.toStringAsFixed(2);
    } else {
      bmiController.text = '';
    }
  }

  void updateUserData(String age, String height, String weight, String bmi) {
    String? userEmail = FirebaseAuth.instance.currentUser?.email;

    if (userEmail != null) {
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      CollectionReference usersCollection = firestore.collection('users');

      usersCollection.doc(userEmail).update({
        'age': age,
        'height': height,
        'weight': weight,
        'bmi': bmi,
      }).then((_) {
        // Güncelleme başarılı
        print('Veriler başarıyla güncellendi.');
      }).catchError((error) {
        // Hata durumunda
        print('Veriler güncellenirken bir hata oluştu: $error');
      });
    } else {
      print('Kullanıcı email bilgisi null.');
    }
  }
}
