import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_quiz_app/2_Second_Assign/about.dart';
import 'package:flutter_quiz_app/5_Quiz_App/screens/home.dart';
import 'package:flutter_quiz_app/5_Quiz_App/screens/signin.dart';
import 'package:flutter_quiz_app/5_Quiz_App/widgets/widgets.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBar(context),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Welcome to Our Quiz App!',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'Create quizzes as a teacher or take quizzes as a student.',
              style: TextStyle(
                fontSize: 18.0,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 40.0),
            ElevatedButton(
              onPressed: () {
                // Handle teacher login
                Navigator.push(
                  context,
                  //MaterialPageRoute(builder: (context) => Home()),
                  MaterialPageRoute(builder: (context) => SignIn()),

                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                textStyle: TextStyle(fontSize: 18, color: const Color.fromARGB(255, 236, 234, 234)), // Text color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text('Login as Teacher' ),
            ),
            SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: () {
                // Handle student login
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignIn()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                textStyle: TextStyle(fontSize: 18, color: Colors.white), // Text color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text('Login as Student'),
            ),
          ],
        ),
      ),
    );
  }
}
