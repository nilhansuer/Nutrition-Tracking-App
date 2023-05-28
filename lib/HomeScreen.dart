import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      drawer: SideBar(),
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
          var userName = userData['name'];
          var userAge = userData['age'];
          var userWeight = userData['weight'];
          var userHeight = userData['height'];
          var userAim = userData['aim'];
          var userBMI = userData['bmi'];

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Welcome to the Nutrition Tracker App!',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '"Create healthy habits, not restrictions."',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.blue,
                  child: Text(
                    userName[0],
                    style: TextStyle(
                      fontSize: 32,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Hi, $userName!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                Card(
                  color: Colors.greenAccent[100],
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: ListTile(
                    leading: Icon(Icons.calendar_today),
                    title: Text('Age'),
                    subtitle: Text(userAge.toString()),
                  ),
                ),
                Card(
                  color: Colors.orangeAccent[100],
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: ListTile(
                    leading: Icon(Icons.monitor_weight),
                    title: Text('Weight'),
                    subtitle: Text(userWeight.toString()),
                  ),
                ),
                Card(
                  color: Colors.pinkAccent[100],
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: ListTile(
                    leading: Icon(Icons.height),
                    title: Text('Height'),
                    subtitle: Text(userHeight.toString()),
                  ),
                ),
                SizedBox(height: 10),
                Card(
                  color: Colors.purpleAccent[100],
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: ListTile(
                    leading: Icon(Icons.insert_chart_outlined_rounded),
                    title: Text('Aim'),
                    subtitle: Text(userAim.toString()),
                  ),
                ),
                SizedBox(height: 10),
                Card(
                  color: Colors.yellowAccent[100],
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: ListTile(
                    leading: Icon(Icons.accessibility_new_outlined),
                    title: Text('Body-Mass Index'),
                    subtitle: Text(userBMI.toString()),
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


class SideBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            height: 200,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(
                    'https://img.freepik.com/free-photo/pots-vegetables-harvest_23-2147694057.jpg',
                  ),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'MENU BAR',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.add_home_outlined),
            title: Text('Home'),
            trailing: Icon(Icons.arrow_back_ios_new),
            tileColor: Colors.greenAccent,
            onTap: () => Navigator.pushNamed(context, "/HomeScreen"),
          ),
          ListTile(
            leading: Icon(Icons.article_outlined),
            title: Text('Meal List'),
            trailing: Icon(Icons.arrow_forward_ios_outlined),
            onTap: () => Navigator.pushNamed(context, "/MealList"),
          ),
          ListTile(
            leading: Icon(Icons.accessibility_new_outlined),
            title: Text('Daily Aim & Results'),
            trailing: Icon(Icons.arrow_forward_ios_outlined),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.app_settings_alt),
            title: Text('Settings'),
            trailing: Icon(Icons.arrow_forward_ios_outlined),
            onTap: () => Navigator.pushNamed(context, "/UserSettings"),
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, "/LoginScreen", (route) => false);
            },
          ),
        ],
      ),
    );
  }
}

