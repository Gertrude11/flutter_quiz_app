// import 'package:flutter/material.dart';
// import 'package:flutter_quiz_app/2_Second_Assign/drawer_widget.dart';


// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key}) : super(key: key);

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   var _currentIndex = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "HOME",
//           style: TextStyle(
//             fontSize: 30,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         backgroundColor: Colors.white,
//         elevation: 5,
//         centerTitle: true,
//         actions: [
//           IconButton(
//             icon: Icon(
//               Icons.notifications,
//               size: 28,
//               color: Colors.grey[800],
//             ),
//             onPressed: () {
//               // Handle notifications button press
//             },
//           ),
//           IconButton(
//             icon: Icon(
//               Icons.settings,
//               size: 28,
//               color: Colors.grey[800],
//             ),
//             onPressed: () {
//               // Handle settings button press
//             },
//           ),
//         ],
//       ),
//       drawer: DrawerWidget(),
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [Colors.white, Colors.grey[200]!],
//           ),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             SizedBox(height: 100),
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: const Text(
//                 'Welcome To Mobile App',
//                 style: TextStyle(
//                   color: Colors.black,
//                   fontSize: 50,
//                   fontWeight: FontWeight.bold,
//                   fontFamily: 'Pacifico-Regular',
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(right: 50.0),
//               child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color.fromARGB(255, 78, 140, 190),
//                   padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
//                 ),
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => LoginScreen()),
//                   );
//                 },
//                 child: Row(
//                   children: const [
//                     Text(
//                       'Log in',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 25,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     Icon(
//                       Icons.keyboard_arrow_right,
//                       size: 40,
//                       color: Colors.white,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//             Padding(
//               padding: const EdgeInsets.only(left: 50.0),
//               child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color.fromARGB(255, 135, 209, 138),
//                   padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
//                 ),
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => SignUpScreen()),
//                   );
//                 },
//                 child: Row(
//                   children: const [
//                     Text(
//                       'Register',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 25,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     Icon(
//                       Icons.keyboard_arrow_right,
//                       size: 40,
//                       color: Colors.white,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             Container(
//               margin: EdgeInsets.symmetric(vertical: 20.0),
//               height: 550.0,
//               child: ListView(
//                 scrollDirection: Axis.horizontal,
//                 children: <Widget>[
//                   // Add your widgets for the horizontal ListView
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: BottomNavigationBarWidget(
//         currentIndex: _currentIndex,
//         onTap: (int indexOfItem) {
//           setState(() {
//             _currentIndex = indexOfItem;
//           });

//           // Handle bottom navigation item taps here
//           switch (indexOfItem) {
//             case 1:
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => CalculatorScreen()),
//               );
//               break;
//             case 2:
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => AboutUsPage()),
//               );
//               break;
//           }
//         },
//       ),
//     );
//   }
// }
