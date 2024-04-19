import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_quiz_app/5_Quiz_App/services/database.dart';
import 'package:flutter_quiz_app/5_Quiz_App/widgets/widgets.dart';
import 'package:random_string/random_string.dart';

class EditQuiz extends StatefulWidget {
  final String quizId; // Pass quizId when editing

  const EditQuiz({Key? key, required this.quizId}) : super(key: key);

  @override
  State<EditQuiz> createState() => _EditQuizState();
}

class _EditQuizState extends State<EditQuiz> {
  final _formKey = GlobalKey<FormState>();
  late String quizTitle = "", quizDesc="";
  late DatabaseService databaseService;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    databaseService = DatabaseService();
    if (widget.quizId != null) {
      // Load existing quiz data if in edit mode
      loadQuizData();
    }
  }

  void loadQuizData() async {
    try {
      final quizData = await databaseService.getQuestionData(widget.quizId);
      if (quizData.docs.isNotEmpty) {
        final firstDocument = quizData.docs.first;
        setState(() {
          quizTitle = firstDocument["quizTitle"];
          quizDesc = firstDocument["quizDesc"];
        });
      } else {
        print("Quiz data not found for quizId: ${widget.quizId}");
      }
    } catch (e) {
      print("Error loading quiz data: $e");
    }
  }

  void updateQuizOnline() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      if (widget.quizId != null) {
        // If in edit mode, update existing quiz data
        // Call updateQuizData instead of addQuizData
        await databaseService.updateQuizData({
          "quizTitle": quizTitle,
          "quizDesc": quizDesc,
        } as String, widget.quizId as Map<String, dynamic>);
      } else {
        // If not in edit mode, add new quiz data
        String quizId = randomAlphaNumeric(16);
        await databaseService.addQuizData({
          "quizId": quizId,
          "quizTitle": quizTitle,
          "quizDesc": quizDesc,
        }, quizId);
      }

      setState(() {
        _isLoading = false;
      });

      // Navigate back after creating or editing quiz
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBar(context),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        iconTheme: IconThemeData(color: Colors.black87),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Form(
              key: _formKey,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    TextFormField(
                      initialValue: quizTitle, // Set initial value if in edit mode
                      validator: (val) {
                        return val!.isEmpty ? "Enter quiz title" : null;
                      },
                      decoration: InputDecoration(hintText: "Quiz Title"),
                      onChanged: (val) {
                        quizTitle = val;
                      },
                    ),
                    SizedBox(height: 6),
                    TextFormField(
                      initialValue: quizDesc, // Set initial value if in edit mode
                      validator: (val) {
                        return val!.isEmpty ? "Enter quiz Description" : null;
                      },
                      decoration: InputDecoration(hintText: "Quiz Description"),
                      onChanged: (val) {
                        quizDesc = val;
                      },
                    ),
                    SizedBox(height: 6),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        updateQuizOnline();
                      },
                      child: blueButton(context: context, label: "Save Quiz"),
                    ),
                    SizedBox(height: 60),
                  ],
                ),
              ),
            ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter_quiz_app/5_Quiz_App/services/database.dart';

// import 'add_question.dart';

// class ModifyQuizPage extends StatefulWidget {
//   final String quizId;

//   ModifyQuizPage({required this.quizId});

//   @override
//   _ModifyQuizPageState createState() => _ModifyQuizPageState();
// }

// class _ModifyQuizPageState extends State<ModifyQuizPage> {
//   late Stream<DocumentSnapshot> quizDataStream;
//   late Stream<QuerySnapshot> questionDataStream;
//   late DatabaseService databaseService;

//   @override
//   void initState() {
//     super.initState();
//     databaseService = DatabaseService(id: widget.quizId);
//     // Get the quiz data stream directly
//     quizDataStream = databaseService.getQuizData3(widget.quizId);
//     // Get the question data stream directly
//     questionDataStream = databaseService.getQuestionData2(widget.quizId);
//   }

//   // Method to delete a question
//   Future<void> deleteQuestion(String questionId) async {
//     try {
//       await databaseService.deleteQuestion(widget.quizId, questionId);
//     } catch (e) {
//       print('Error deleting question: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Modify Quiz'),
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: EdgeInsets.all(16.0),
//             child: Text(
//               'Quiz Details',
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//           ),
//           StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
//             stream: quizDataStream
//                 as Stream<DocumentSnapshot<Map<String, dynamic>>>?,
//             builder: (context,
//                 AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>>
//                     snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return CircularProgressIndicator();
//               }
//               if (!snapshot.hasData ||
//                   snapshot.data == null ||
//                   snapshot.data!.data() == null) {
//                 return Text('No quiz data found.');
//               }
//               var quizData = snapshot.data!.data()! as Map<String, dynamic>;
//               return ListTile(
//                 title: Text('Title: ${quizData['quizTitle']}'),
//                 subtitle: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text('Description: ${quizData['quizDesc']}'),
//                    // Text('Image URL: ${quizData['quizImgUrl'] ?? ''}'),
//                   ],
//                 ),
//                 trailing: IconButton(
//                   icon: Icon(Icons.edit),
//                   onPressed: () {
//                     // Navigate to a page to edit quiz details
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => EditQuizPage(
//                           quizId: widget.quizId,
//                           currentTitle: quizData['quizTitle'],
//                           currentDesc: quizData['quizDesc'],
//                           //currentImage: quizData['quizImgUrl'],
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               );
//             },
//           ),
//           Padding(
//             padding: EdgeInsets.all(16.0),
//             child: Text(
//               'Questions',
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//           ),
//           Expanded(
//             child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
//               stream: questionDataStream
//                   as Stream<QuerySnapshot<Map<String, dynamic>>>?,
//               builder: (context,
//                   AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return CircularProgressIndicator();
//                 }
//                 if (!snapshot.hasData) {
//                   return Text('No questions found.');
//                 }
//                 var questions = snapshot.data!.docs;
//                 return ListView.builder(
//                   itemCount: questions.length,
//                   itemBuilder: (context, index) {
//                     var questionData =
//                         questions[index].data() as Map<String, dynamic>;
//                     return ListTile(
//                       title: Text(
//                           'Question ${index + 1}: ${questionData['question']}'),
//                       trailing: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           IconButton(
//                             icon: Icon(Icons.edit),
//                             onPressed: () {
//                               // Navigate to a page to edit the question
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => EditQuestionPage(
//                                     quizId: widget.quizId,
//                                     questionId: questions[index].id,
//                                     currentQuestion: questionData['question'],
//                                     currentOptions: [
//                                       questionData['option1'],
//                                       questionData['option2'],
//                                       questionData['option3'],
//                                       questionData['option4'],
//                                     ],
//                                   ),
//                                 ),
//                               );
//                             },
//                           ),
                    

//                         ],
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//           SizedBox(height: 16),
//           Align(
//   alignment: Alignment.center,
//   child: Column(
//     children: [
//       ElevatedButton.icon(
//         onPressed: () {
//           // Navigate to the AddQuestion page with the quiz ID
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(
//               builder: (context) => AddQuestion(
//                 quizId: widget.quizId, // Pass the quiz ID to AddQuestion page
//                 databaseService: databaseService,
//               ),
//             ),
//           );
//         },
//         icon: Icon(Icons.add),
//         label: Text('Add Question'),
//       ),
    
//     ],
//   ),
// ),

//         ],
//       ),
//     );
//   }
// }

// class EditQuizPage extends StatefulWidget {
//   final String quizId;
//   final String currentTitle;
//   final String currentDesc;
//  // final String currentImage;

//   EditQuizPage(
//       {required this.quizId,
//       required this.currentTitle,
//       required this.currentDesc,
//      // required this.currentImage
//      });

//   @override
//   _EditQuizPageState createState() => _EditQuizPageState();
// }

// class _EditQuizPageState extends State<EditQuizPage> {
//   late TextEditingController _titleController;
//   late TextEditingController _descController;
//   late TextEditingController _imageUrlController;

//   @override
//   void initState() {
//     super.initState();
//     _titleController = TextEditingController(text: widget.currentTitle);
//     _descController = TextEditingController(text: widget.currentDesc);
//    // _imageUrlController = TextEditingController(text: widget.currentImage);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Edit Quiz'),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('Title'),
//             TextFormField(
//               controller: _titleController,
//             ),
//             SizedBox(height: 16),
//             Text('Description'),
//             TextFormField(
//               controller: _descController,
//             ),
//             SizedBox(height: 16),
//             Text('Image URL'), // Display the label for the imageUrl
//             TextFormField(
//               controller: _imageUrlController,
//             ),
//             SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: () {
//                 // Update quiz details in the database
//                 DatabaseService(uid: widget.quizId).updateQuizData(
//                   widget.quizId,
//                   {
//                     'quizTitle': _titleController.text,
//                     'quizDesc': _descController.text,
//                     'quizImgUrl': _imageUrlController
//                         .text, // Include imageUrl in the update data
//                   },
//                 );
//                 Navigator.pop(context);
//               },
//               child: Text('Save'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class EditQuestionPage extends StatefulWidget {
//   final String quizId;
//   final String questionId;
//   final String currentQuestion;
//   final List<String> currentOptions;

//   EditQuestionPage(
//       {required this.quizId,
//       required this.questionId,
//       required this.currentQuestion,
//       required this.currentOptions});

//   @override
//   _EditQuestionPageState createState() => _EditQuestionPageState();
// }

// class _EditQuestionPageState extends State<EditQuestionPage> {
//   late TextEditingController _questionController;
//   late List<TextEditingController> _optionControllers;

//   @override
//   void initState() {
//     super.initState();
//     _questionController = TextEditingController(text: widget.currentQuestion);
//     _optionControllers = List.generate(
//       widget.currentOptions.length,
//       (index) => TextEditingController(text: widget.currentOptions[index]),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Edit Question'),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('Question'),
//             TextFormField(
//               controller: _questionController,
//             ),
//             SizedBox(height: 16),
//             Text('Options'),
//             for (int i = 0; i < _optionControllers.length; i++)
//               TextFormField(
//                 controller: _optionControllers[i],
//               ),
//             SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: () {
//                 // Update question details in the database
//                 DatabaseService(uid: widget.quizId).updateQuestionData(
//                   widget.quizId,
//                   widget.questionId,
//                   {
//                     'question': _questionController.text,
//                     'option1': _optionControllers[0].text,
//                     'option2': _optionControllers[1].text,
//                     'option3': _optionControllers[2].text,
//                     'option4': _optionControllers[3].text,
//                   },
//                 );
//                 Navigator.pop(context);
//               },
//               child: Text('Save'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
