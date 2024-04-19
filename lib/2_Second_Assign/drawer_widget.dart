import 'package:flutter/material.dart';
import 'package:flutter_quiz_app/1_First_Assign/Calculator.dart';
import 'package:flutter_quiz_app/2_Second_Assign/about.dart';
import 'package:flutter_quiz_app/5_Quiz_App/screens/compass_app.dart';
import 'package:flutter_quiz_app/5_Quiz_App/screens/light.dart';
import 'package:flutter_quiz_app/5_Quiz_App/screens/logout.dart';
import 'package:flutter_quiz_app/5_Quiz_App/screens/map.dart';
import 'package:flutter_quiz_app/5_Quiz_App/screens/steps_counter.dart';
import 'package:flutter_quiz_app/5_Quiz_App/screens/student_home.dart';



class DrawerWidget extends StatelessWidget {
   

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        child: ListView(
          padding: const EdgeInsets.all(0),
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 21, 140, 238),
              ),
              child: UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: Color.fromARGB(255, 21, 140, 238)),
                accountName: Text(
                  "User",
                  style: TextStyle(fontSize: 18),
                ),
                accountEmail: Text("gerturde23@gmail.com"),
                currentAccountPictureSize: Size.square(50),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.greenAccent,
                  child: Image.network(
                    "https://images.unsplash.com/photo-1529778873920-4da4926a72c2?q=80&w=1636&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                    height: 50.0,
                    width: 50.0,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text(' My Profile '),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => AboutUsPage()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.home_filled),
              title: const Text(' My Home '),
              onTap: () {
                Navigator.pop(context);
                
              },
            ),
            ListTile(
              leading: const Icon(Icons.workspace_premium),
              title: const Text(' My Calculator '),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => CalculatorScreen()));
              },
            ),
             ListTile(
              leading: const Icon(Icons.light),
              title: const Text(' Light Sensor '),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => LightSensor()));
              },
            ),
              ListTile(
              leading: const Icon(Icons.map),
              title: const Text(' My Map'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => MapPage()));
              },
            ),
             ListTile(
              leading: const Icon(Icons.fitness_center),
              title: const Text(' My Fitness'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => StepsCounter()));
              },
            ),
             ListTile(
              leading: const Icon(Icons.compass_calibration),
              title: const Text(' My Compass'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => CompassPage()));
              },
            ),
              ListTile(
              leading: const Icon(Icons.local_activity_outlined),
              title: const Text(' DoQuiz '),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => StudentHome()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.local_activity_outlined),
              title: const Text(' Logout '),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => Logout()));
              },
            ),
            
           
          ],
        ),
      ),
    );
  }
}
