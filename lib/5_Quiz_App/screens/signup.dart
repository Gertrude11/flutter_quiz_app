import 'package:flutter/material.dart';
import 'package:flutter_quiz_app/2_Second_Assign/about.dart';
import 'package:flutter_quiz_app/5_Quiz_App/helper/function.dart';
import 'package:flutter_quiz_app/5_Quiz_App/screens/home.dart';
import 'package:flutter_quiz_app/5_Quiz_App/screens/signin.dart';
import 'package:flutter_quiz_app/5_Quiz_App/services/auth.dart';
import 'package:flutter_quiz_app/5_Quiz_App/widgets/widgets.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  late String name, email, password;
  AuthService authService = AuthService();
  bool isLoading = false;

  void signUp() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      await authService.signUpWithEmailAndPassword(email, password).then((value) {
        if (value != null) {
          setState(() {
            isLoading = false;
          });
          Constants.saveUserLoggedInSharedPreference(isUserLoggedIn: true);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => AboutUsPage()),
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Sign Up in DoQuiz App",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color.fromARGB(255, 238, 81, 42),
        elevation: 0,
        centerTitle: true,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Center(
              child: Card(
                margin: EdgeInsets.symmetric(horizontal: 24),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          validator: (val) {
                            return val!.isEmpty ? "Enter Your Name" : null;
                          },
                          decoration: InputDecoration(
                            hintText: "Name",
                          ),
                          onChanged: (val) {
                            name = val;
                          },
                        ),
                        SizedBox(height: 12),
                        TextFormField(
                          validator: (val) {
                            return val!.isEmpty ? "Enter Your Email" : null;
                          },
                          decoration: InputDecoration(
                            hintText: "Email",
                          ),
                          onChanged: (val) {
                            email = val;
                          },
                        ),
                        SizedBox(height: 12),
                        TextFormField(
                          obscureText: true,
                          validator: (val) {
                            return val!.isEmpty ? "Enter Your Password" : null;
                          },
                          decoration: InputDecoration(
                            hintText: "Password",
                          ),
                          onChanged: (val) {
                            password = val;
                          },
                        ),
                        SizedBox(height: 24),
                        GestureDetector(
                          onTap: signUp,
                          child: blueButton(
                            context: context,
                            label: "Sign Up",
                          ),
                        ),
                        SizedBox(height: 18),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Already have an account? ",
                              style: TextStyle(fontSize: 15.5),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (context) => SignIn()),
                                );
                              },
                              child: Text(
                                "Sign In",
                                style: TextStyle(
                                  fontSize: 15.5,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
