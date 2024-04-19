import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:ClassMe/services/QuizDatabaseHelper.dart';

class DatabaseService {
  //final String uid;
  //late DatabaseHelper dbHelper;

  // DatabaseService({required this.uid}) {
  //   //dbHelper = DatabaseHelper();
  // }

  // Future<void> addData(Map<String, dynamic> userData) async {
  //   await FirebaseFirestore.instance
  //       .collection("users")
  //       .add(userData)
  //       // ignore: body_might_complete_normally_catch_error
  //       .catchError((e) {
  //     print(e);
  //   });
  // }

  getData() async {
    return await FirebaseFirestore.instance.collection("users").snapshots();
  }

  Future<void> addQuizData(Map<String, dynamic> quizData, String quizId) async {
    await FirebaseFirestore.instance
        .collection("Quizz")
        .doc(quizId)
        .set(quizData)
        .catchError((e) {
      print(e);
    });

    // Insert quiz data into SQLite
    //await dbHelper.insertQuiz(quizData);
  }

  Future<void> addQuestionData(
      Map<String, dynamic> questionData, String quizId) async {
    await FirebaseFirestore.instance
        .collection("Quizz")
        .doc(quizId)
        .collection("QNA")
        .add(questionData)
        .catchError((e) {
      print(e);
    });

    // Insert question data into SQLite
    // await dbHelper.insertQuestion(questionData);
  }

  getQuizDataById(String quizId) async {
    return await FirebaseFirestore.instance
        .collection("Quiz")
        .doc(quizId)
        .get();
  }

  getQuizData() async {
    return await FirebaseFirestore.instance.collection("Quizz").snapshots();
  }

  getQuestionData(String quizId) async {
    return await FirebaseFirestore.instance
        .collection("Quizz")
        .doc(quizId)
        .collection("QNA")
        .get();
  }

  // Method to get all quiz data
  getAllQuizData() async {
    return await FirebaseFirestore.instance.collection("Quizz").get();
  }

  getQuizData2() async {
    return await FirebaseFirestore.instance.collection("Quizz").snapshots();
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getQuizData3(String quizId) {
    return FirebaseFirestore.instance
        .collection("Quizz")
        .doc(quizId)
        .snapshots();
  }

  Stream<QuerySnapshot> getQuestionData2(String quizId) {
    return FirebaseFirestore.instance
        .collection("Quizz")
        .doc(quizId)
        .collection("QNA")
        .snapshots();
  }

  Future<void> updateQuizData(
      String quizId, Map<String, dynamic> updatedData) async {
    await FirebaseFirestore.instance
        .collection("Quizz")
        .doc(quizId)
        .update(updatedData)
        .catchError((e) {
      print(e);
    });

    // Update quiz data in SQLite
    //await dbHelper.updateQuiz(quizId, updatedData);
  }

  Future<void> updateQuestionData(String quizId, String questionId,
      Map<String, dynamic> updatedData) async {
    await FirebaseFirestore.instance
        .collection("Quizz")
        .doc(quizId)
        .collection("QNA")
        .doc(questionId)
        .update(updatedData)
        .catchError((e) {
      print(e);
    });

    // Update question data in SQLite
    //await dbHelper.updateQuestion(questionId, updatedData, quizId);
  }

  Future<void> deleteQuestion(String quizId, String questionId) async {
    await FirebaseFirestore.instance
        .collection("Quizz")
        .doc(quizId)
        .collection("QNA")
        .doc(questionId)
        .delete()
        .catchError((e) {
      print(e);
    });

    // Delete question data from SQLite
    //await dbHelper.deleteQuestion(questionId, quizId);
  }

  Future<void> deleteQuizData(String quizId) async {
    await FirebaseFirestore.instance
        .collection("Quizz")
        .doc(quizId)
        .delete()
        .catchError((e) {
      print(e);
    });

    // Delete quiz data from SQLite
    //await dbHelper.deleteQuiz(quizId);
  }
}



// import 'package:cloud_firestore/cloud_firestore.dart';

// class DatabaseService {

//   // Ensure Firebase is initialized only once
//   // static Future<void> _initializeFirebase() async {
//   //   if (Firebase.apps.isEmpty) {
//   //     await Firebase.initializeApp();

//   // }
//   Future<void> addQuizData(Map<String, dynamic> quizData, String quizId) async {
//     await FirebaseFirestore.instance
//         .collection("Quiz")
//         .doc(quizId)
//         .set(quizData) 
//         .catchError((e) {
//       print(e.toString());
//     });
//   }

// // Future<void> addQuestionData(Map<String, dynamic> quizData, String quizId) async {
// //   try {
// //     // Add question data to the "QNA" collection
// //     // Include the quizId in the question data to indicate which quiz it belongs to
// //     quizData['quizId'] = quizId;
// //     await FirebaseFirestore.instance
// //         .collection("QNA")
// //         .add(quizData);

// //     print('Question data added successfully');
// //   } catch (e) {
// //     print('Error adding question data: $e');
// //   }
// // }



//    Future<void> addQuestionData(quizData, String quizId) async {
//     await FirebaseFirestore.instance
//         .collection("Quiz")
//         .doc(quizId)
//         .collection("QNA")
//         .add(quizData)
//         .catchError((e) {
//       print(e);
//     });
//   }



//   // Future<void> addQuestionData(Map<String,dynamic> quizData, String quizId)async{
//   //   await FirebaseFirestore.instance
//   //   .collection("Quiz")
//   //   .doc(quizId)
//   //   .collection("QNA")
//   //   .add(quizData)
//   //   .catchError((e) {
//   //     print(e);
//   //   });
//   // }

// //   Future<void> addQuestionData(Map<String, dynamic> quizData, String quizId) async {
// //   print('Adding question data to quizId: $quizId');
// //   try {
// //     await FirebaseFirestore.instance
// //       .collection("Quiz")
// //       .doc(quizId)
// //       .collection("QNA")
// //       .add(quizData);
// //     print('Question data added successfully');
// //   } catch (e) {
// //     print('Error adding question data: $e');
// //   }
// // }

// //   Future<void> addQuestionData(Map<String, dynamic> questionData, String quizId) async {
// //   if (quizId.isNotEmpty) {
// //     await FirebaseFirestore.instance
// //         .collection("Quiz")
// //         .doc(quizId)
// //         .collection("QNA")
// //         .add(questionData)
// //         .catchError((e) {
// //           print(e.toString());
// //         });
// //   } else {
// //     print("Error: quizId is null or empty.");
// //   }
// // }

// getQuizData() async{
//   return await FirebaseFirestore.instance
//     .collection("Quiz").snapshots();
// }
// getQuestionData(String quizId) async{
//   return await FirebaseFirestore.instance
//   .collection("Quiz")
//   .doc(quizId)
//   .collection("QNA")
//   .get(); 
// }

// Future<void> updateQuizData(Map<String, dynamic> updatedQuizData, String quizId) async {
//   try {
//     await FirebaseFirestore.instance
//         .collection("Quiz")
//         .doc(quizId)
//         .update(updatedQuizData);
//     print('Quiz data updated successfully');
//   } catch (e) {
//     print('Error updating quiz data: $e');
//   }
// }
// Future<void> deleteQuizData(String quizId) async {
//   try {
//     await FirebaseFirestore.instance
//         .collection("Quiz")
//         .doc(quizId)
//         .delete();
//     print('Quiz data deleted successfully');
//   } catch (e) {
//     print('Error deleting quiz data: $e');
//   }
// }

// }
