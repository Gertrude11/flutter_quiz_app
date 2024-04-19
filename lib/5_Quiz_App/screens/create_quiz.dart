import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_quiz_app/5_Quiz_App/screens/add_question.dart';
import 'package:flutter_quiz_app/5_Quiz_App/screens/showup.dart';
import 'package:flutter_quiz_app/5_Quiz_App/services/database.dart';
import 'package:flutter_quiz_app/5_Quiz_App/widgets/widgets.dart';
import 'package:random_string/random_string.dart';

class CreateQuiz extends StatefulWidget {
  const CreateQuiz({super.key});

  @override
  State<CreateQuiz> createState() => _CreateQuizState();
}

class _CreateQuizState extends State<CreateQuiz> {

  final _formKey = GlobalKey<FormState>();
  late String quizTitle, quizDesc,quizId;
  DatabaseService databaseService =new DatabaseService();

  bool _isLoading = false;

  CreateQuizOnline() async{
    if(_formKey.currentState!.validate()){

      setState(() {
        _isLoading = true;
      });
      quizId = randomAlphaNumeric(16);

      Map<String, String> quizMap ={
        "quizId" : quizId,
        "quizTitle" : quizTitle,
        "quizDesc" : quizDesc
      };
      await databaseService.addQuizData(quizMap, quizId).then((value){
        setState(() {
        _isLoading = false;
      showPopup(context, 'Success', 'quiz created successfully!');

        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => AddQuestion(
            quizId,
          )
          ));
        });
      });

    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBar(context),
        backgroundColor: Colors.transparent,
        elevation: 0.0, systemOverlayStyle: SystemUiOverlayStyle.light,
        iconTheme: IconThemeData(color: Colors.black87),
      ),
      body: _isLoading ? Container(
        child: Center(child: CircularProgressIndicator(),),
      ): Form(
        key: _formKey,
        child: Container(
          padding:  EdgeInsets.symmetric(horizontal: 24),
          child:Column(children: [

            //for quiz title
            TextFormField(
            validator: (val){return val!.isEmpty ? "Enter quiz title" : null;},
            decoration: InputDecoration(
              hintText: "Quiz Title"
            ),
            onChanged: (val){
            quizTitle = val;
            },
          ),
          SizedBox(height: 6,),

          //for quiz description
          TextFormField(
            validator: (val){return val!.isEmpty ? "Enter quiz Description" : null;},
            decoration: InputDecoration(
              hintText: "Quiz Description"
            ),
            onChanged: (val){
            quizDesc = val;
            },
          ),
          SizedBox(height: 6,),
          
          Spacer(),
          GestureDetector(
            onTap: (){
              CreateQuizOnline();
            },
            child: blueButton(
              context: context,
              label: "Create New Quiz")),
          SizedBox(height: 60,),


            
          ],),),
      )
    );
  }
}