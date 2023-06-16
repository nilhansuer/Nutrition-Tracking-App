import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MealListPage extends StatefulWidget {
  const MealListPage({Key? key}) : super(key: key);

  @override
  _MealListPageState createState() => _MealListPageState();
}

class _MealListPageState extends State<MealListPage> {
  final User? user = FirebaseAuth.instance.currentUser;
  List<Map<String, dynamic>> mealList = [];
  int totalCalories = 0;
  double bmi = 0;
  int maxCalories = 0;


  @override
  void initState() {
    super.initState();
    getBMI(user!.email!).then((bmiValue) {
      bmi = double.parse(bmiValue);
      generateMealList();
    });
  }


  Future<String> getGender(String email) async {
    String gender;
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(email)
          .get();
      gender = (snapshot.data() as Map<String, dynamic>)['gender'].toString();
    } catch (e) {
      gender = 'Unknown';
    }
    return gender;
  }


  Future<String> getBMI(String email) async {
    String bmi;
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(email)
          .get();
      bmi = (snapshot.data() as Map<String, dynamic>)['bmi'].toString();
    } catch (e) {
      bmi = '0';
    }
    return bmi;
  }


  int calculateCalories(String gender, double bmi) {
    if (gender == 'Female') {
      if (bmi >= 30) {
        return 2000;
      } else {
        return 1500; // Default value for female users with BMI below 30
      }
    } else if (gender == 'Male') {
      if (bmi >= 30) {
        return 1500;
      } else {
        return 1800; // Default value for male users with BMI below 30
      }
    }
    return 0; // Default value if no conditions match
  }

  void calculateTotalCalories(List<Map<String, dynamic>> mealList) {
    int totalCalories = 0;

    for (var meal in mealList) {
      if (meal['isChecked']) {
        totalCalories += meal['calories'] as int;
      }
    }

    setState(() {
      this.totalCalories = totalCalories;
    });

    if (maxCalories == 0 && totalCalories > maxCalories) {
      maxCalories = 2000; // Update maxCalories to 2000 when it's initially zero
    }

    if (maxCalories > 0 && totalCalories > maxCalories) {
      showOverconsumptionMessage();
    }
  }

  void generateMealList() async {
    String gender = await getGender(user!.email!);
    double bmi = double.parse(await getBMI(user!.email!));

    setState(() {
      maxCalories = calculateCalories(gender, bmi);
    });

    // Add meals to the mealList
    mealList = [
      {
        'name': 'Eggs',
        'calories': 180,
        'isChecked': false,
      },
      {
        'name': 'Pasta',
        'calories': 800,
        'isChecked': false,
      },
      {
        'name': 'Steak',
        'calories': 900,
        'isChecked': false,
      },
      {
        'name': 'Broccoli Soup',
        'calories': 206,
        'isChecked': false,
      },
      {
        'name': 'Bagel',
        'calories': 310,
        'isChecked': false,
      },
      {
        'name': 'cornflakes',
        'calories': 370,
        'isChecked': false,
      },
      {
        'name': 'Macaroni',
        'calories': 320,
        'isChecked': false,
      },
      {
        'name': 'Noodles',
        'calories': 175,
        'isChecked': false,
      },
      {
        'name': 'Boiled Potatoes',
        'calories': 210,
        'isChecked': false,
      },
      {
        'name': 'Rice',
        'calories': 420,
        'isChecked': false,
      },
      {
        'name': 'apple',
        'calories': 44,
        'isChecked': false,
      },
      {
        'name': 'Banana',
        'calories': 107,
        'isChecked': false,
      },
      {
        'name': 'Blackberries',
        'calories': 25,
        'isChecked': false,
      },
      {
        'name': 'Cherry',
        'calories': 50,
        'isChecked': false,
      },
      {
        'name': 'Steak',
        'calories': 900,
        'isChecked': false,
      },
      {
        'name': 'Grapes',
        'calories': 62,
        'isChecked': false,
      },
      {
        'name': 'Grapefruit',
        'calories': 32,
        'isChecked': false,
      },
      {
        'name': 'Burrito',
        'calories': 320,
        'isChecked': false,
      },
      {
        'name': 'California Roll',
        'calories': 198,
        'isChecked': false,
      },
      {
        'name': 'Fish and Chips',
        'calories': 585,
        'isChecked': false,
      },
      {
        'name': 'Grilled Cheese Sandwich',
        'calories': 392,
        'isChecked': false,
      },
      {
        'name': 'Hummus',
        'calories': 435,
        'isChecked': false,
      },
      {
        'name': 'Kebab',
        'calories': 774,
        'isChecked': false,
      },
      {
        'name': 'Mac and Cheese',
        'calories': 699,
        'isChecked': false,
      },
      {
        'name': 'pizza',
        'calories': 772,
        'isChecked': false,
      },
      {
        'name': 'Potato Salad',
        'calories': 136,
        'isChecked': false,
      },
      {
        'name': 'Ramen',
        'calories': 380,
        'isChecked': false,
      },
      {
        'name': 'Roast Beef',
        'calories': 23,
        'isChecked': false,
      },
      {
        'name': 'Sausage Roll',
        'calories': 101,
        'isChecked': false,
      },
      {
        'name': 'Spaghetti Bolognese',
        'calories': 374,
        'isChecked': false,
      },
      {
        'name': 'Carrot Soup',
        'calories': 95,
        'isChecked': false,
      },
      {
        'name': 'Meatball Soup',
        'calories': 120,
        'isChecked': false,
      },
      {
        'name': 'Pumpkin Soup',
        'calories': 71,
        'isChecked': false,
      },
      {
        'name': 'Tomato Soup',
        'calories': 74,
        'isChecked': false,
      },
      {
        'name': 'Vegetable soup',
        'calories': 67,
        'isChecked': false,
      }
    ];
    setState(() {
      maxCalories = calculateCalories(gender, bmi);
    });
  }

  void showOverconsumptionMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Calorie intake exceeded the recommended limit!'),
        action: SnackBarAction(
          label: 'OK',
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  void handleCheckboxValueChanged(int index, bool value) {
    setState(() {
      mealList[index]['isChecked'] = value;
      calculateTotalCalories(mealList);
    });

    if (totalCalories > maxCalories) {
      showOverconsumptionMessage();
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meal List'),
      ),
      body: SingleChildScrollView(
        child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: mealList.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                mealList[index]['name'],
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                '${mealList[index]['calories']} calories',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              trailing: Checkbox(
                value: mealList[index]['isChecked'],
                activeColor: Colors.green,
                onChanged: (value) {
                  handleCheckboxValueChanged(index, value!);
                },
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Total Calories: $totalCalories',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
        ),
      ),
    );
  }
}