import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_quiz_app/5_Quiz_App/widgets/widgets.dart';

class Results extends StatefulWidget {
  final int correct,incorrect,total;
  const Results({super.key, required this.correct, required this.incorrect, required this.total});

  @override
  State<Results> createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Text("${widget.correct}/${widget.total}",style: TextStyle(fontSize: 25),),
            SizedBox(height: 8,),
            Text("Congrats for finishing doing quiz on DoQuiz App! You have corrected ${widget.correct} answers and " 
            "${widget.incorrect} failed answers ",style: TextStyle(fontSize: 15,color: Colors.grey),
            textAlign: TextAlign.center,),
            SizedBox(height: 14,),
            GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: blueButton(context: context, label: "Back to Home",buttonWidth: MediaQuery.of(context).size.width/2))

          ],),
        ),
      ),
    );
  }
}