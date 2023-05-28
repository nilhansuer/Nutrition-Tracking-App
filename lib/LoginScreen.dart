import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nutrition_tracker_app/SignupScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
                    PageTitle(),
                    SizedBox(height: 100),
                    SignInText(),
                    SizedBox(height: 20),
                    SubText(),
                    SizedBox(height: 40),
                    EmailInput(emailcontroller: _emailController),
                    SizedBox(height: 40),
                    PasswordInput(passwordcontroller: _passwordController),
                    SizedBox(height: 40),
                    SignInButton(
                      emailcontroller: _emailController,
                      passwordcontroller: _passwordController,
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
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Forgot Password?",
          style: TextStyle(
            fontSize: 20,
            color: Color(0xff7a7a7a),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SignupScreen()));
          },
          child: Text(
            "Sign Up",
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
  const SignInButton(
      {Key? key,
      required this.passwordcontroller,
      required this.emailcontroller})
      : super(key: key);

  @override
  State<SignInButton> createState() => _SignInButtonState();
}

class _SignInButtonState extends State<SignInButton> {
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    double width = MediaQuery.of(context).size.width;
    Future<void> _login() async {
      try {
        final UserCredential userCredential =
            await _auth.signInWithEmailAndPassword(
          email: widget.emailcontroller.text.trim(),
          password: widget.passwordcontroller.text.trim(),
        );

        // Giriş işlemi başarılı, kullanıcı oturumu açıldı
        User? user = userCredential.user;
        if (user != null) {
          Navigator.pushNamed(context, "/HomeScreen");
        }
      } catch (e) {
        // Giriş işlemi başarısız
        print('Giriş sırasında bir hata oluştu: $e');
      }
    }

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
        onPressed: _login,
        child: Text(
          "Sign in",
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
  const PasswordInput({Key? key, required this.passwordcontroller})
      : super(key: key);

  @override
  State<PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  var _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
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
              hintText: "Password",
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
              hintText: "Email",
            ),
          ),
        ),
      ],
    );
  }
}

class SubText extends StatelessWidget {
  const SubText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "Hi there! Nice to see you again.",
          style: TextStyle(
            color: Color(0xff6c6c6c),
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}

class SignInText extends StatelessWidget {
  const SignInText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: 50,
          height: 50,
          child: Image.asset(
            "assets/images/leaf.png",
            color: Color(0xff11446e),
          ),
        ),
        Text(
          "Sign In",
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

class PageTitle extends StatelessWidget {
  const PageTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      "Nutrition Tracker",
      style: TextStyle(
        fontSize: 30.0,
        color: Color(0xff11446e),
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
