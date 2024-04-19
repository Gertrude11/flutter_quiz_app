import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_quiz_app/1_First_Assign/Calculator.dart';
import 'package:flutter_quiz_app/2_Second_Assign/drawer_widget.dart';
import 'package:flutter_quiz_app/5_Quiz_App/widgets/widgets.dart';



class AboutUsPage extends StatefulWidget {
  const AboutUsPage({Key? key}) : super(key: key);

  @override
  _AboutUsPageState createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  int _currentIndex = 1; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        title: appBar(context),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      
      drawer: DrawerWidget(),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            
            Image.network(
              'https://images.unsplash.com/photo-1551836022-8b2858c9c69b?q=80&w=1740&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
              height: 100,
            ),
            SizedBox(height: 20),
            // Company name and description
            Text(
              'Pro-Flutter',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 80, 141, 221),
              ),
            ),
            SizedBox(height: 10),
            Text(
              'FlutterCalc is a versatile and user-friendly calculator app designed and built using Flutter,'
              ' a powerful open-source UI software development toolkit by Google. This app provides a seamless'
              ' and intuitive way to perform basic to advanced mathematical calculations right from your mobile device.',
              textAlign: TextAlign.center,
              style:TextStyle(
                fontSize: 22,
              )
            ),
            SizedBox(height: 20),
            // Other relevant information
            Text('Address: Kigali-Rwanda'),
            Text('Email: info@pro.com.com'),
            Text('Phone: +2507863566532'),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        fixedColor: Color.fromARGB(255, 80, 141, 221),
        items: const [
          
          BottomNavigationBarItem(
            label: "Calculator",
            icon: Icon(Icons.workspace_premium),
          ),
          BottomNavigationBarItem(
            label: "Profile",
            icon: Icon(Icons.account_circle),
          ),
        ],
        onTap: (int indexOfItem) {
          // Handle bottom navigation item taps here
          setState(() {
            _currentIndex = indexOfItem;
          });

          switch (indexOfItem) {
            
            case 0:
              // Navigate to Calculator screen
              Navigator.push(context, MaterialPageRoute(builder: (context) => CalculatorScreen()));
              break;
            case 1:
              // Navigate to Profile screen
            Navigator.push(context, MaterialPageRoute(builder: (context) => AboutUsPage()));

              break;
          }
        },
      ),
    );
  }
}