// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_quiz_app/5_Quiz_App/screens/play_quiz.dart';
// import 'package:flutter_quiz_app/5_Quiz_App/screens/showup.dart';
// import 'package:flutter_quiz_app/5_Quiz_App/services/database.dart';
// import 'package:flutter_quiz_app/5_Quiz_App/widgets/widgets.dart';
// import 'package:google_fonts/google_fonts.dart';

// class StudentHome extends StatefulWidget {
//   const StudentHome({Key? key}) : super(key: key);

//   @override
//   State<StudentHome> createState() => _HomeState();
// }

// class _HomeState extends State<StudentHome> {
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
//     showPopup(context, 'Welcome Back', 'You have new quiz!');
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
//                 id: data["quizId"],
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
//               'List of Quizzes available',
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
//     );
//   }
// }

// class QuizTile extends StatelessWidget {
//   final String title;
//   final String desc;
//   final String id;

//   const QuizTile({
//     Key? key,
//     required this.title,
//     required this.desc,
//     required this.id,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => QuizPlay(id),
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
//                     ElevatedButton(
//                       onPressed: () {
//                         // Add do quiz functionality
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => QuizPlay(id),
//                           ),
//                         );
//                       },
//                       child: Text("Take Quiz"),
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


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_quiz_app/5_Quiz_App/screens/play_quiz.dart';
import 'package:flutter_quiz_app/5_Quiz_App/screens/showup.dart';
import 'package:flutter_quiz_app/5_Quiz_App/services/database.dart';
import 'package:flutter_quiz_app/5_Quiz_App/widgets/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class StudentHome extends StatefulWidget {
  const StudentHome({Key? key}) : super(key: key);

  @override
  State<StudentHome> createState() => _HomeState();
}

class _HomeState extends State<StudentHome> {
  late Stream quizStream;
  DatabaseService databaseService = DatabaseService();

  @override
  void initState() {
    super.initState();
    getQuizData();
  }

  void getQuizData() async {
    quizStream = await databaseService.getQuizData();
    setState(() {});
    showPopup(context, 'Welcome Back', 'You have new quiz!');
  }

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
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Text(
              'List of Quizzes available',
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
    );
  }
}

class QuizTile extends StatefulWidget {
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
  _QuizTileState createState() => _QuizTileState();
}

class _QuizTileState extends State<QuizTile> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isSelected = !_isSelected;
        });
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => QuizPlay(widget.id),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: _isSelected ? Colors.blue : Colors.black26, // Change color based on selection
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
                  widget.title,
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
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _isSelected = !_isSelected;
                        });
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => QuizPlay(widget.id),
                          ),
                        );
                      },
                      child: Text("Take Quiz"),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 6),
            Text(
              widget.desc,
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
