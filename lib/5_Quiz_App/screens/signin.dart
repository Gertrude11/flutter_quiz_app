import 'package:flutter/material.dart';
import 'package:flutter_quiz_app/2_Second_Assign/about.dart';
import 'package:flutter_quiz_app/5_Quiz_App/helper/function.dart';
import 'package:flutter_quiz_app/5_Quiz_App/screens/home.dart';
import 'package:flutter_quiz_app/5_Quiz_App/screens/signup.dart';
import 'package:flutter_quiz_app/5_Quiz_App/services/auth.dart';
import 'package:flutter_quiz_app/5_Quiz_App/widgets/widgets.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  late String email, password;
  AuthService authService = AuthService();

  bool isLoading = false;

  // void signIn() async {
  //   if (_formKey.currentState!.validate()) {
  //     setState(() {
  //       isLoading = true;
  //     });
  //     await authService.signInEmailAndPass(email, password).then((val) {
  //       if (val != null) {
  //         setState(() {
  //           isLoading = false;
  //         });
  //         Constants.saveUserLoggedInSharedPreference(isUserLoggedIn: true);
  //         Navigator.pushReplacement(
  //           context,
  //           MaterialPageRoute(builder: (context) => AboutUsPage()),
  //         );
  //       }
  //     });
  //   }
  // }

  void signIn() async {
  if (_formKey.currentState!.validate()) {
    setState(() {
      isLoading = true;
    });

    // Hardcoded teacher's credentials
    String teacherEmail = 'teacher@gmail.com';
    String teacherPassword = 'teacher123';

    // Check if the entered email and password match the teacher's credentials
    if (email == teacherEmail && password == teacherPassword) {
      // Teacher authentication
      // You can handle teacher's authentication separately, such as navigating to a teacher-specific screen
      // For now, let's just print a message
      print('Teacher authenticated');
      setState(() {
        isLoading = false;
      });
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Home()),
          );
    } else {
      // Proceed with the regular authentication process for students
      await authService.signInEmailAndPass(email, password).then((val) {
        if (val != null) {
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
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Sign In DoQuiz App",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color.fromARGB(255, 238, 81, 42), // Change the background color
        elevation: 0, // Remove the shadow
        centerTitle: true,
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
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
                            return val!.isEmpty ? "Enter correct Email" : null;
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
                            return val!.isEmpty ? "Enter correct Password" : null;
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
                          onTap: signIn,
                          child: blueButton(
                            context: context,
                            label: "Sign In",
                          ),
                        ),
                        SizedBox(height: 18),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account? ",
                              style: TextStyle(fontSize: 15.5),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (context) => SignUp()),
                                );
                              },
                              child: Text(
                                "Sign Up",
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
