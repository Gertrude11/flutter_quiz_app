import 'package:flutter/material.dart';
import 'package:flutter_quiz_app/5_Quiz_App/screens/Welcome.dart';
import 'package:flutter_quiz_app/5_Quiz_App/services/auth.dart';

class Logout extends StatelessWidget {
  const Logout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Logout'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            // Call the signOut method from AuthService
            await AuthService().signOut();
            // Navigate back to Welcome screen
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Welcome()),
            );
          },
          child: Text('Logout'),
        ),
      ),
    );
  }
}
