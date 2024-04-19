import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_quiz_app/5_Quiz_App/screens/create_quiz.dart';
import 'package:flutter_quiz_app/5_Quiz_App/screens/edit_quiz.dart';
import 'package:flutter_quiz_app/5_Quiz_App/screens/play_quiz.dart';
import 'package:flutter_quiz_app/5_Quiz_App/services/database.dart';
import 'package:flutter_quiz_app/5_Quiz_App/widgets/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int myIndex = 0;
  bool isOnline = false;
  bool isBluetoothEnabled = false;

  late Timer refreshTimer;
  bool showStatusIndicators = true;
  late Stream quizStream;
  DatabaseService databaseService = DatabaseService();

  // @override
  // void initState() {
  //   super.initState();
  //   getQuizData();
  // }
  @override
  void initState() {
    // Initialize the database service with a unique ID
    databaseService = DatabaseService();

    // Initialize quizStream with an empty stream
    quizStream = Stream.empty();

    // Show a notification when the page loads
    showWelcomeNotification();

    // Load quiz data into quizStream
    databaseService.getQuizData().then((value) {
      setState(() {
        quizStream = value;
      });
    });
    super.initState();

    // Check for internet connectivity
    checkInternetConnectivity().then((result) {
      setState(() {
        isOnline = result;
      });
    });

    // Set up periodic timer for refreshing every 1 minute
    refreshTimer = Timer.periodic(Duration(seconds: 2), (Timer timer) {
      refreshStatus();
    });
    getQuizData();
  }

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initNotifications() async {
    final AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('classme');

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: (String? payload) async {
        // Handle notification tap
      },
    );
  }

  void getQuizData() async {
    quizStream = await databaseService.getQuizData();
    setState(() {});
  }

  Future<void> showWelcomeNotification() async {
  //   Fluttertoast.showToast(
  //   msg: 'Welcome back! We have more quiz for you today.',
  //   toastLength: Toast.LENGTH_LONG, // Duration for the pop-up
  //   gravity: ToastGravity.BOTTOM, // Location on the screen
  //   backgroundColor: Colors.grey[800], // Background color of the pop-up
  //   textColor: Colors.white, // Text color of the pop-up
  // );
    // Define the notification details
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'quiz_channel', // ID for the notification channel
      'Quiz Notifications', // Name of the notification channel
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    // Show the notification
    await flutterLocalNotificationsPlugin.show(
      0, // Notification ID
      'Welcome back!', // Notification title
      'We have more quiz for you today.', // Notification body
      platformChannelSpecifics,
      payload: 'quiz_notification', // Optional payload
    );
  }

  @override
  void dispose() {
    // Cancel the timer when the widget is disposed
    refreshTimer.cancel();
    super.dispose();
  }

  void refreshStatus() {
    // Check and update the status of internet connectivity and Bluetooth
    checkInternetConnectivity().then((result) {
      setState(() {
        isOnline = result;
      });
    });
  }

  Future<bool> checkInternetConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  // Future<bool> checkBluetoothStatus() async {
  //   try {
  //     FlutterBlue flutterBlue = FlutterBlue.instance;

  //     // Create a Completer to handle the async operation
  //     Completer<bool> completer = Completer<bool>();

  //     // Initialize the subscription variable
  //     late StreamSubscription<BluetoothState> subscription;

  //     // Listen to the first event emitted by the Bluetooth state stream
  //     subscription = flutterBlue.state.listen((BluetoothState bluetoothState) {
  //       // Check the Bluetooth state and complete the Future
  //       completer.complete(bluetoothState == BluetoothState.on);

  //       // Cancel the subscription after the first event
  //       subscription.cancel();
  //     });

  //     return await completer.future; // Wait for the Future to complete
  //   } catch (e, stackTrace) {
  //     print('Error in checkBluetoothStatus: $e\n$stackTrace');
  //     return false;
  //   }
  // }

  Widget quizList() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24),
      child: StreamBuilder(
        stream: quizStream,
        builder: (context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          if (!snapshot.hasData) {
            return Text('No Data');
          }
          return ListView.builder(
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context, index) {
              var data = snapshot.data.docs[index].data();
              return QuizTile(
                desc: data["quizDesc"],
                title: data["quizTitle"],
                id: data["quizId"],
              );
            },
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBar(context),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        // Display notification icon or badge here
        actions: [
          IconButton(
            onPressed: () {
              // Navigate to notifications screen
            },
            icon: Icon(Icons.notifications),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Text(
              'List of Quizzes',
              style: GoogleFonts.lato(
                textStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            child: quizList(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateQuiz()),
          );
        },
      ),
    );
  }
}

class QuizTile extends StatelessWidget {
  final String title;
  final String desc;
  final String id;

  const QuizTile({
    Key? key,
    required this.title,
    required this.desc,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => QuizPlay(id),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.black26,
        ),
        alignment: Alignment.center,
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.symmetric(vertical: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(
                      color: Color.fromARGB(255, 221, 91, 51),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        // Add edit quiz functionality
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            //await DatabaseService.updateQuizData(quizId);
                            builder: (context) => EditQuiz(quizId: id),
                          ),
                        );
                      },
                      icon: Icon(Icons.edit),
                      color: Colors.blue,
                    ),
                    IconButton(
                      onPressed: () {
                        // Add delete quiz functionality
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Delete Quiz"),
                              content: Text(
                                  "Are you sure you want to delete this quiz?"),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("Cancel"),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    await DatabaseService().deleteQuizData(id);
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("Delete"),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      icon: Icon(Icons.delete),
                      color: Colors.red,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 6),
            Text(
              desc,
              style: GoogleFonts.lato(
                textStyle: TextStyle(
                  color: const Color.fromARGB(255, 8, 8, 8),
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


 





















// class Home extends StatefulWidget {
//   const Home({Key? key}) : super(key: key);

//   @override
//   State<Home> createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   late Stream quizStream;
//   DatabaseService databaseService = DatabaseService();

//   @override
//   void initState() {
//     super.initState();
//     getQuizData();
//   }

//   void getQuizData() async {
//     quizStream = await databaseService.getQuizsData();
//     setState(() {});
//   }

//   Widget quizList() {
//     return Container(
//       margin: EdgeInsets.symmetric(horizontal: 24),
//       child: StreamBuilder(
//         stream: quizStream,
//         builder: (context, AsyncSnapshot<dynamic> snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           }
//           if (snapshot.hasError) {
//             return Text('Error: ${snapshot.error}');
//           }
//           if (!snapshot.hasData) {
//             return Text('No Data');
//           }
//           return ListView.builder(
//             itemCount: snapshot.data.docs.length,
//             itemBuilder: (context, index) {
//               var data = snapshot.data.docs[index].data();
//               return QuizTile(
//                 desc: data["quizDesc"],
//                 title: data["quizTitle"],
//                 quizId: data["quizId"],
//                // noOfQuestions: data["noOfQuestions"],
//               );
//             },
//           );
//         },
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: appBar(context),
//         backgroundColor: Colors.transparent,
//         elevation: 0.0,
//         systemOverlayStyle: SystemUiOverlayStyle.light,
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
//             child: Text(
//               'List of Quizzes',
//               style: GoogleFonts.lato(
//                 textStyle: TextStyle(
//                   color: Colors.black,
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ),
//           Expanded(
//             child: quizList(),
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         child: Icon(Icons.add),
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => CreateQuiz()),
//           );
//         },
//       ),
//     );
//   }
// }

// // class QuizTile extends StatelessWidget {
// //   final String title;
// //   final String desc;
// //   final String quizId;
// //   //final int noOfQuestions;

// //   const QuizTile(
// //       {Key? key,
// //       required this.title,
// //       required this.desc,
// //       required this.quizId,
// //      // required this.noOfQuestions
// //      })
// //       : super(key: key);

// //   @override
// //   Widget build(BuildContext context) {
// //     return GestureDetector(
// //       onTap: () {
// //         Navigator.push(
// //           context,
// //           MaterialPageRoute(
// //             builder: (context) => QuizPlay(
// //               quizId,
// //             ),
// //           ),
// //         );
// //       },
// //       child: Container(
// //         decoration: BoxDecoration(
// //           borderRadius: BorderRadius.circular(8),
// //           color: Colors.black26,
// //         ),
// //         alignment: Alignment.center,
// //         padding: EdgeInsets.all(16),
// //         margin: EdgeInsets.symmetric(vertical: 8),
// //         child: Column(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             Text(
// //               title,
// //               style: GoogleFonts.lato(
// //                 textStyle: TextStyle(
// //                     color: Color.fromARGB(255, 221, 91, 51),
// //                     fontSize: 20,
// //                     fontWeight: FontWeight.bold),
// //               ),
// //             ),
// //             SizedBox(height: 6),
// //             Text(
// //               desc,
// //               style: GoogleFonts.lato(
// //                 textStyle: TextStyle(
// //                     color: const Color.fromARGB(255, 8, 8, 8),
// //                     fontSize: 16,
// //                     fontWeight: FontWeight.normal),
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }


// class QuizTile extends StatelessWidget {
//   final String title;
//   final String desc;
//   final String quizId;

//   const QuizTile({
//     Key? key,
//     required this.title,
//     required this.desc,
//     required this.quizId,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => QuizPlay(quizId),
//           ),
//         );
//       },
//       child: Container(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(8),
//           color: Colors.black26,
//         ),
//         alignment: Alignment.center,
//         padding: EdgeInsets.all(16),
//         margin: EdgeInsets.symmetric(vertical: 8),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   title,
//                   style: GoogleFonts.lato(
//                     textStyle: TextStyle(
//                       color: Color.fromARGB(255, 221, 91, 51),
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//                 Row(
//                   children: [
//                     // IconButton(
//                     //   onPressed: () {
//                     //     // Add edit quiz functionality
//                     //     // Navigator.push(
//                     //     //  // context,
//                     //     //  // MaterialPageRoute(
//                     //     //     //builder: (context) => EditQuiz(quizId: quizId),
//                     //     //   //),
//                     //     // );
//                     //   },
//                     //   icon: Icon(Icons.edit),
//                     //   color: Colors.blue,
//                     // ),
//                     IconButton(
//                       onPressed: () {
//                         // Add delete quiz functionality
//                         showDialog(
//                           context: context,
//                           builder: (BuildContext context) {
//                             return AlertDialog(
//                               title: Text("Delete Quiz"),
//                               content: Text("Are you sure you want to delete this quiz?"),
//                               actions: [
//                                 TextButton(
//                                   onPressed: () {
//                                     Navigator.of(context).pop();
//                                   },
//                                   child: Text("Cancel"),
//                                 ),
//                                 // TextButton(
//                                 //   onPressed: () {
                                    
//                                 //     // Perform delete action
//                                 //     // This is where you would call a method to delete the quiz
//                                 //     Navigator.of(context).pop();
//                                 //   },
//                                 //   child: Text("Delete"),
//                                 // ),
//                                 IconButton(
//   onPressed: () {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text("Delete Quiz"),
//           content: Text("Are you sure you want to delete this quiz?"),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text("Cancel"),
//             ),
//             TextButton(
//               onPressed: () async {
//                 await DatabaseService().deleteQuizData(quizId);
//                 Navigator.of(context).pop();
//               },
//               child: Text("Delete"),
//             ),
//           ],
//         );
//       },
//     );
//   },
//   icon: Icon(Icons.delete),
//   color: Colors.red,
// ),

//                               ],
//                             );
//                           },
//                         );
//                       },
//                       icon: Icon(Icons.delete),
//                       color: Colors.red,
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             SizedBox(height: 6),
//             Text(
//               desc,
//               style: GoogleFonts.lato(
//                 textStyle: TextStyle(
//                   color: const Color.fromARGB(255, 8, 8, 8),
//                   fontSize: 16,
//                   fontWeight: FontWeight.normal,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }




// class QuizTile extends StatelessWidget {
//   final String title;
//   final String desc;
//   final String quizId;

//   const QuizTile({Key? key, required this.title, required this.desc, required this.quizId})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => PlayQuiz(
//               quizId: quizId,
//             ),
//           ),
//         );
//       },
//       child: Container(
//         decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
//         color: Colors.black26,
//         alignment: Alignment.center,
//         child: Column(
//           children: [
//             Text(
//               title,
//               style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w500),
//             ),
//             SizedBox(height: 6),
//             Text(
//               desc,
//               style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w400),
//             ),
//           ],
//         ),
//       ),
//     );
//   }



// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_quiz_app/5_Quiz_App/screens/create_quiz.dart';
// import 'package:flutter_quiz_app/5_Quiz_App/services/database.dart';
// import 'package:flutter_quiz_app/5_Quiz_App/widgets/widgets.dart';

// class Home extends StatefulWidget {
//   const Home({Key? key}) : super(key: key);

//   @override
//   State<Home> createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   late Stream quizStream;
//   DatabaseService databaseService = DatabaseService();

//   @override
//   void initState() {
//     super.initState();
//     getQuizData();
//   }

//   void getQuizData() async {
//     quizStream = await databaseService.getQuizData();
//     setState(() {});
//   }

//   Widget quizList() {
//   return Container(
//     margin: EdgeInsets.symmetric(horizontal: 24),
//     child: StreamBuilder(
//       stream: quizStream,
//       builder: (context, AsyncSnapshot<dynamic> snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return CircularProgressIndicator();
//         }
//         if (snapshot.hasError) {
//           return Text('Error: ${snapshot.error}');
//         }
//         if (!snapshot.hasData || snapshot.data.documents == null) {
//           return Text('No Data');
//         }
//         return ListView.builder(
//           itemCount: snapshot.data.documents.length,
//           itemBuilder: (context, index) {
//             return QuizTile(
//               desc: snapshot.data.documents[index].data["quizDesc"],
//               title: snapshot.data.documents[index].data["quizTitle"],
//             );
//           },
//         );
//       },
//     ),
//   );
// }


//   // Widget quizList() {
//   //   return Container(
//   //     margin: EdgeInsets.symmetric(horizontal: 24),
//   //     child: StreamBuilder(
//   //       stream: quizStream,
//   //       builder: (context, AsyncSnapshot<dynamic> snapshot) {
//   //         if (snapshot.connectionState == ConnectionState.waiting) {
//   //           return CircularProgressIndicator();
//   //         }
//   //         if (snapshot.hasError) {
//   //           return Text('Error: ${snapshot.error}');
//   //         }
//   //         if (!snapshot.hasData) {
//   //           return Text('No Data');
//   //         }
//   //         return ListView.builder(
//   //           itemCount: snapshot.data.documents.length,
//   //           itemBuilder: (context, index) {
//   //             return QuizTile(
//   //               desc: snapshot.data.documents[index].data["quizDesc"],
//   //               title: snapshot.data.documents[index].data["quizTitle"],
//   //             );
//   //           },
//   //         );
//   //       },
//   //     ),
//   //   );
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: appBar(context),
//         backgroundColor: Colors.transparent,
//         elevation: 0.0,
//         systemOverlayStyle: SystemUiOverlayStyle.light,
//       ),
//       body: quizList(),
//       floatingActionButton: FloatingActionButton(
//         child: Icon(Icons.add),
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => CreateQuiz()),
//           );
//         },
//       ),
//     );
//   }
// }

// class QuizTile extends StatelessWidget {
//   final String title;
//   final String desc;

//   const QuizTile({Key? key, required this.title, required this.desc})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
//       color: Colors.black26,
//       alignment: Alignment.center,
//       child: Column(
//         children: [
//           Text(
//             title,
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 17,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//           SizedBox(height: 6),
//           Text(
//             desc,
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 14,
//               fontWeight: FontWeight.w400,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
