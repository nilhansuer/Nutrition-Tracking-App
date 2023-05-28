import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nutrition_tracker_app/LoginScreen.dart';
import 'package:nutrition_tracker_app/RegisterScreen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  String userType = "patient";
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
                    SignUpText(),
                    SizedBox(height: 40),
                    EmailInput(emailcontroller: _emailController),
                    SizedBox(height: 40),
                    PasswordInput(
                      passwordcontroller: _passwordController,
                    ),
                    SizedBox(height: 40),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "User Type",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff11446e),
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: RadioListTile(
                                title: Text("Patient",
                                    style: TextStyle(fontSize: 14)),
                                value: "patient",
                                visualDensity: VisualDensity(
                                  horizontal: VisualDensity.minimumDensity,
                                  vertical: VisualDensity.minimumDensity,
                                ),
                                groupValue: userType,
                                onChanged: (value) {
                                  setState(() {
                                    userType = value.toString();
                                  });
                                },
                              ),
                            ),
                            Expanded(
                              child: RadioListTile(
                                title: Text("Dietitan",
                                    style: TextStyle(fontSize: 14)),
                                value: "dietitan",
                                groupValue: userType,
                                visualDensity: VisualDensity(
                                  horizontal: VisualDensity.minimumDensity,
                                  vertical: VisualDensity.minimumDensity,
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    userType = value.toString();
                                  });
                                },
                              ),
                            ),
                            Expanded(
                              child: RadioListTile(
                                title: Text("Doctor",
                                    style: TextStyle(fontSize: 14)),
                                value: "doctor",
                                visualDensity: VisualDensity(
                                  horizontal: VisualDensity.minimumDensity,
                                  vertical: VisualDensity.minimumDensity,
                                ),
                                groupValue: userType,
                                onChanged: (value) {
                                  setState(() {
                                    userType = value.toString();
                                  });
                                },
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 70),
                    SignInButton(
                      emailcontroller: _emailController,
                      passwordcontroller: _passwordController,
                      usertype: userType,
                    ),
                    SizedBox(height: 70),
                    ForgotAndSignUpText(),
                    SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ForgotAndSignUpText extends StatelessWidget {
  const ForgotAndSignUpText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Have an Account?",
          style: TextStyle(
            fontSize: 20,
            color: Color(0xff7a7a7a),
          ),
        ),
        SizedBox(width: 10),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => LoginScreen()));
          },
          child: Text(
            "Sign in",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xff11446e),
            ),
          ),
        ),
      ],
    );
  }
}

class SignInButton extends StatefulWidget {
  final TextEditingController passwordcontroller;
  final TextEditingController emailcontroller;
  final String usertype;
  const SignInButton(
      {Key? key,
      required this.passwordcontroller,
      required this.emailcontroller,
      required this.usertype})
      : super(key: key);

  @override
  State<SignInButton> createState() => _SignInButtonState();
}

class _SignInButtonState extends State<SignInButton> {
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;

    Future<void> _register() async {
      try {
        final UserCredential userCredential =
            await _auth.createUserWithEmailAndPassword(
          email: widget.emailcontroller.text.trim(),
          password: widget.passwordcontroller.text.trim(),
        );
        User? user = userCredential.user;
        if (user != null) {
          FirebaseFirestore.instance
              .collection('users') // Verileri ekleyeceğiniz koleksiyon adı
              .doc(widget.emailcontroller.text) // Belge (document) ID'si
              .set({"usertype": widget.usertype})
              .then((value) {})
              .catchError((error) {});
          Navigator.pushNamed(context, "/LoginScreen");
        }
      } catch (e) {
        print('Kayıt sırasında bir hata oluştu: $e');
      }
    }

    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: width,
      height: 60,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // <-- Radius
          ),
          backgroundColor: Color(0xff11446e),
        ),
        onPressed: () {
          if (widget.usertype == "patient") {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => RegisterScreen(
                        password: widget.passwordcontroller.text,
                        email: widget.emailcontroller.text,
                        usertype: widget.usertype,
                      )),
            );
          } else {
            _register();
          }
        },
        child: Text(
          "Continue",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class PasswordInput extends StatefulWidget {
  final TextEditingController passwordcontroller;
  PasswordInput({Key? key, required this.passwordcontroller}) : super(key: key);
  @override
  State<PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  var _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Password",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
            color: Color(0xff11446e),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: TextField(
            controller: widget.passwordcontroller,
            obscureText: !_passwordVisible,
            enableSuggestions: false,
            autocorrect: false,
            decoration: InputDecoration(
              hintText: "Your password",
              suffixIcon: IconButton(
                icon: Icon(
                  _passwordVisible ? Icons.visibility : Icons.visibility_off,
                  color: Color(0xff888888),
                ),
                onPressed: () {
                  setState(() {
                    _passwordVisible = !_passwordVisible;
                  });
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class EmailInput extends StatelessWidget {
  final TextEditingController emailcontroller;
  const EmailInput({Key? key, required this.emailcontroller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Email",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
            color: Color(0xff11446e),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: TextField(
            controller: emailcontroller,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: "Your email address",
            ),
          ),
        ),
      ],
    );
  }
}

class SignUpText extends StatelessWidget {
  const SignUpText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "Sign Up",
          style: TextStyle(
            fontSize: 30.0,
            color: Color(0xff11446e),
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
