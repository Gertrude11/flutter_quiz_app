import 'package:flutter/material.dart';
import 'package:flutter_quiz_app/2_Second_Assign/about.dart';
import 'package:flutter_quiz_app/5_Quiz_App/helper/function.dart';
import 'package:flutter_quiz_app/5_Quiz_App/screens/Welcome.dart';
import 'package:firebase_core/firebase_core.dart';


// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//  void main(){
//   FlutterError.onError = (details) {
//     FlutterError.presentError(details);
//     if (kReleaseMode) exit(1);
//   };
//   runApp(const MyApp());
// }


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyCM4xVj3APu8kI_IFPrJCW-SPmo3IiHgu0", // Use the API key from the JSON
      appId: "1:710181106129:android:613cf5b41f85ba493e70f0", // Use the mobilesdk_app_id from the JSON
      messagingSenderId: "your_messaging_sender_id_here", // Use the messagingSenderId from the JSON
      projectId: "mid-project-ff35e", // Use the project_id from the JSON
      storageBucket: "mid-project-ff35e.appspot.com" // Use the storage_bucket from the JSON
    )
  );
  runApp(MyApp());
}



// class MyApp extends StatefulWidget {
//   const MyApp({super.key});

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {

//   bool _isLoggedin = false;
//   @override
//   void initState() {
//     checkUserLoggedInStatus();
//     super.initState();
//   }

//   checkUserLoggedInStatus() async{
//     HelperFunction.getUserLoginDetails().then((value) => {
//       setState(() {
//         _isLoggedin = value!;
//       })
//     });
//   }
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Quiz App',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//        primarySwatch: Colors.blue,
//        visualDensity: VisualDensity.adaptivePlatformDensity,
//        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//        // useMaterial3: true,
//       ),
//       home: _isLoggedin  ? Home() : SignIn(),
//     );
//   } 
// }

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isUserLoggedIn = false;

  @override
  void initState() {
    getLoggedInState();
    super.initState();
  }

  getLoggedInState() async {
    await Constants.getUerLoggedInSharedPreference().then((value) {
      setState(() {
        isUserLoggedIn != value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Quiz App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // ignore: prefer_const_constructors
      home: isUserLoggedIn ?  AboutUsPage() : Welcome(),
    );
  }
}