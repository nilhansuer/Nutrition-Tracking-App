import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  final String email;
  final String usertype;
  final String password;
  const RegisterScreen(
      {Key? key,
        required this.email,
        required this.usertype,
        required this.password})
      : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String genderType = '';
  String aim = '';
  String weightInput = '';
  String heightInput = '';

  final _nameController = TextEditingController();
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();
  final _agecontroller = TextEditingController();
  final _bmiController = TextEditingController();

  String dropdownValue = 'One';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                child: Column(
                  children: [
                    //PageIcon(),
                    NameInput(namecontroller: _nameController),
                    SizedBox(height: 8),
                    AgeInput(agecontroller: _agecontroller),
                    SizedBox(height: 8),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Gender",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff11446e),
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: RadioListTile(
                                title: Text("Female",
                                    style: TextStyle(fontSize: 14)),
                                value: "female",
                                visualDensity: VisualDensity(
                                  horizontal: VisualDensity.minimumDensity,
                                  vertical: VisualDensity.minimumDensity,
                                ),
                                groupValue: genderType,
                                onChanged: (value) {
                                  setState(() {
                                    genderType = value.toString();
                                  });
                                },
                              ),
                            ),
                            Expanded(
                              child: RadioListTile(
                                title: Text("Male",
                                    style: TextStyle(fontSize: 14)),
                                value: "male",
                                groupValue: genderType,
                                visualDensity: VisualDensity(
                                  horizontal: VisualDensity.minimumDensity,
                                  vertical: VisualDensity.minimumDensity,
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    genderType = value.toString();
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Height",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: Color(0xff11446e),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 0.2),
                          child: TextField(
                            keyboardType: TextInputType.number,
                            controller: _heightController,
                            decoration: InputDecoration(
                              hintText: "Enter your height in cm",
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Weight",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: Color(0xff11446e),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 0.2),
                          child: TextField(
                            keyboardType: TextInputType.number,
                            controller: _weightController,
                            decoration: InputDecoration(
                              hintText: "Enter your weight in kg",
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    TextFormField(
                      controller: _bmiController,
                      decoration: InputDecoration(
                        labelText: 'BMI',
                      ),
                    ),
                    SizedBox(height: 1),
                    ElevatedButton(
                      child: Text('Calculate BMI'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.pinkAccent[100],
                        fixedSize: Size(200, 10),
                      ),
                      onPressed: () {
                        calculateBMI();
                      },
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            "Select your disease",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: Color(0xff11446e),
                            ),
                          ),
                        ),
                        Expanded(
                          child: DropdownButton<String>(
                            value: dropdownValue,
                            icon: const Icon(Icons.arrow_drop_down),
                            style: const TextStyle(color: Colors.grey),
                            underline: Container(
                              height: 2,
                              color: Colors.white,
                            ),
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownValue = newValue!;
                              });
                            },
                            items: const [
                              DropdownMenuItem<String>(
                                value: 'One',
                                child: Text('Gluten Free'),
                              ),
                              DropdownMenuItem<String>(
                                value: 'Two',
                                child: Text('Celiac'),
                              ),
                              DropdownMenuItem<String>(
                                value: 'Three',
                                child: Text('Beriberi'),
                              ),
                              DropdownMenuItem<String>(
                                value: 'Four',
                                child: Text('Rickets'),
                              ),
                              DropdownMenuItem<String>(
                                value: 'Five',
                                child: Text('Crohns Disease'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 1),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Please choose your aim",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff11446e),
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: RadioListTile(
                                title: Text("Lose Weight",
                                    style: TextStyle(fontSize: 14)),
                                value: "loseweight",
                                visualDensity: VisualDensity(
                                  horizontal: VisualDensity.minimumDensity,
                                  vertical: VisualDensity.minimumDensity,
                                ),
                                groupValue: aim,
                                onChanged: (value) {
                                  setState(() {
                                    aim = value.toString();
                                  });
                                },
                              ),
                            ),
                            Expanded(
                              child: RadioListTile(
                                title: Text("Gain Weight",
                                    style: TextStyle(fontSize: 14)),
                                value: "gainweight",
                                groupValue: aim,
                                visualDensity: VisualDensity(
                                  horizontal: VisualDensity.minimumDensity,
                                  vertical: VisualDensity.minimumDensity,
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    aim = value.toString();
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    RegisterButton(
                      name: _nameController.text,
                      age: _agecontroller.text,
                      aim: aim,
                      disease: dropdownValue,
                      gender: genderType,
                      height: _heightController.text,
                      weight: _weightController.text,
                      bmi: _bmiController.text,
                      email: widget.email,
                      usertype: widget.usertype,
                      password: widget.password,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  void calculateBMI() {
    double height = double.tryParse(_heightController.text) ?? 0;
    double weight = double.tryParse(_weightController.text) ?? 0;

    if (height > 0 && weight > 0) {
      double bmi = weight / ((height / 100) * (height / 100));
      _bmiController.text = bmi.toStringAsFixed(2);
    } else {
      _bmiController.text = '';
    }
  }
}

class NameInput extends StatelessWidget {
  final TextEditingController namecontroller;

  const NameInput({Key? key, required this.namecontroller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Name",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: Color(0xff11446e),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 0.2),
          child: TextFormField(
            controller: namecontroller,
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
              hintText: "Enter your name",
            ),
          ),
        ),
      ],
    );
  }
}

class AgeInput extends StatelessWidget {
  final TextEditingController agecontroller;

  const AgeInput({Key? key, required this.agecontroller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Age",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: Color(0xff11446e),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 0.2),
          child: TextFormField(
            controller: agecontroller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: "Enter your age",
            ),
          ),
        ),
      ],
    );
  }

}

class RegisterButton extends StatelessWidget {
  final String name;
  final String age;
  final String gender;
  final String height;
  final String weight;
  final String disease;
  final String aim;
  final String email;
  final String password;
  final String usertype;
  final String bmi;
  const RegisterButton(
      {Key? key,
        required this.name,
        required this.age,
        required this.gender,
        required this.height,
        required this.weight,
        required this.disease,
        required this.aim,
        required this.email,
        required this.usertype,
        required this.bmi,
        required this.password})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;

    Future<void> _register() async {
      try {
        final UserCredential userCredential =
        await _auth.createUserWithEmailAndPassword(
          email: email.trim(),
          password: password.trim(),
        );
        User? user = userCredential.user;
        if (user != null) {
          FirebaseFirestore.instance
              .collection('users') // Verileri ekleyeceğiniz koleksiyon adı
              .doc(email) // Belge (document) ID'si
              .set({
            "name": name,
            "email": email,
            "age": age,
            "gender": gender,
            "height": height,
            "weight": weight,
            "bmi": bmi,
            "disease": disease,
            "aim": aim,
            "usertype": usertype
          }, SetOptions(merge: true)).then((value) {
            print('Örnek veri eklendi.');
          }).catchError((error) {
            print('Örnek veri eklenirken hata meydana geldi: $error');
          });
        }
        Navigator.pushNamed(context, "/LoginScreen");
      } catch (e) {
        print(e.toString());
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Registration Error'),
                content: Text(e.toString()),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            });
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(

        onPressed: () {
          if (name.isEmpty ||
              age.isEmpty ||
              gender.isEmpty ||
              height.isEmpty ||
              weight.isEmpty ||
              bmi.isEmpty ||
              disease.isEmpty ||
              aim.isEmpty) {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Missing Fields'),
                    content: const Text('Please fill in all fields.'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  );
                });
          } else {
            _register();
          }
        },
        child: const Text('Register'),
        style: ElevatedButton.styleFrom(
          fixedSize: Size(300, 40), // Boyutu istediğin gibi ayarlayabilirsin
        ),
      ),
    );
  }
}


