import 'package:flutter/material.dart';

class MealList extends StatefulWidget {
  const MealList({Key? key}) : super(key: key);

  @override
  State<MealList> createState() => _MealListState();
}

class _MealListState extends State<MealList> {
  List<Map> breakfast = [
    {"name": "1 Boiled Egg", "calories": 78, "isChecked": false},
    {"name": "Half Spoon of Feta Cheese", "calories": 40, "isChecked": false},
    {"name": "1 slice of bread", "calories": 79, "isChecked": false},
    {"name": "1 cup of green tea", "calories": 2, "isChecked": false},
  ];
  List<Map> snacks = [
    {"name": "1 apple", "calories": 95, "isChecked": false},
    {"name": "3 scoops of greek yoghurt", "calories": 150, "isChecked": false},
  ];
  List<Map> lunch = [
    {"name": "a bowl of tomato soup", "calories": 70, "isChecked": false},
    {"name": "1/2 of plate chicken breast", "calories": 165, "isChecked": false},
    {"name": "1/2 of plate salad", "calories": 50, "isChecked": false}
  ];

  int calculateTotalCalories() {
    int totalCalories = 0;

    for (Map food in breakfast) {
      if (food["isChecked"]) {
        totalCalories += food["calories"] as int;
      }
    }

    for (Map food in snacks) {
      if (food["isChecked"]) {
        totalCalories += food["calories"] as int;
      }
    }

    for (Map food in lunch) {
      if (food["isChecked"]) {
        totalCalories += food["calories"]as int;
      }
    }

    return totalCalories;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: const [
            Text("Meal List", style: TextStyle(fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
          ],
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child:
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text("Breakfast", style: TextStyle(fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.teal)),
            const SizedBox(height: 10),
            const Divider(),
            const SizedBox(height: 10),
            Column(
                children: breakfast.map((favorite) {
                  return CheckboxListTile(
                      activeColor: Colors.deepPurpleAccent,
                      checkboxShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      value: favorite["isChecked"],
                      title: Text(favorite["name"], style: const TextStyle(
                          color: Colors.teal)),
                      onChanged: (val) {
                        setState(() {
                          favorite["isChecked"] = val;
                        });
                      });
                }).toList()),

            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text("Snacks", style: TextStyle(fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal)),
              const SizedBox(height: 10),
              const Divider(),
              const SizedBox(height: 10),
              Column(
                  children: snacks.map((favorite) {
                    return CheckboxListTile(
                        activeColor: Colors.deepPurpleAccent,
                        checkboxShape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        value: favorite["isChecked"],
                        title: Text(favorite["name"],
                            style: const TextStyle(color: Colors.teal)),
                        onChanged: (val) {
                          setState(() {
                            favorite["isChecked"] = val;
                          });
                        });
                  }).toList()),

              Column(
                  crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Text("Lunch", style: TextStyle(fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal)),
                const SizedBox(height: 10),
                const Divider(),
                const SizedBox(height: 10),
                Column(
                    children: lunch.map((favorite) {
                      return CheckboxListTile(
                          activeColor: Colors.deepPurpleAccent,
                          checkboxShape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          value: favorite["isChecked"],
                          title: Text(favorite["name"],
                              style: const TextStyle(color: Colors.teal)),
                          onChanged: (val) {
                            setState(() {
                              favorite["isChecked"] = val;
                            });
                          });
                    }).toList()),

              ]),
            ]),
          ]),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 50.0,
          child: Center(
            child: Text('Total Calories: ${calculateTotalCalories()}'),
          ),
        ),
      ),

    );

  }
}

