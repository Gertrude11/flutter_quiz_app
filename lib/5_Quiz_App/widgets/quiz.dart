// import 'package:flutter/material.dart';

// class Option extends StatefulWidget {
//   final String choice, description,correctChoice, choiceSelected;
//   const Option({super.key,
//    required this.choice,
//     required this.description, 
//     required this.correctChoice, 
//     required this.choiceSelected});

//   @override
//   State<Option> createState() => _OptionState();
// }

// class _OptionState extends State<Option> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(vertical: 10),

      
//       child: Row(
//         children: [
//           Container(
//           width: 26,
//           height: 26,
//             decoration: BoxDecoration(
//               border: Border.all(color: widget.description == widget.choiceSelected ?  widget.choiceSelected == widget.correctChoice ? 
//               Colors.green.withOpacity(0.7):Colors.red.withOpacity(0.7) : Colors.grey, width: 1.4),
//               borderRadius: BorderRadius.circular(30),
              
//             ),
//             alignment: Alignment.center,
//             child: Text("${widget.choice}",style: TextStyle(color: widget.choiceSelected == widget.description ?
//             widget.correctChoice == widget.choiceSelected ?
//             Colors.green.withOpacity(0.7):Colors.red: Colors.grey),
//             ),
//           ),
//           SizedBox(width: 8,),
//           Text(widget.description, style: TextStyle(fontSize: 14, color: Colors.green.withOpacity(0.7),
//           ),
//           ),
        
//         ],),
//     );
//   }
// }

import 'package:flutter/material.dart';

class OptionTile extends StatefulWidget {
  final String option, description, correctAnswer, optionSelected;

  OptionTile({
    required this.description,
    required this.correctAnswer,
    required this.option,
    required this.optionSelected,
  });

  @override
  _OptionTileState createState() => _OptionTileState();
}

class _OptionTileState extends State<OptionTile> {
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    ThemeData theme = Theme.of(context);
    Color correctColor = Colors.green.withOpacity(0.7);
    Color incorrectColor = Colors.red.withOpacity(0.7);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          Container(
            height: 28,
            width: 28,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(
                color: widget.optionSelected == widget.description
                    ? widget.description == widget.correctAnswer
                        ? correctColor
                        : incorrectColor
                    : Colors.grey,
                width: 1.5,
              ),
              color: widget.optionSelected == widget.description
                  ? widget.description == widget.correctAnswer
                      ? correctColor
                      : incorrectColor
                  : Colors.white,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Text(
              widget.option,
              style: TextStyle(
                color: widget.optionSelected == widget.description
                    ? Colors.white
                    : Colors.grey,
              ),
            ),
          ),
          SizedBox(
            width: 8,
          ),
          Text(
            widget.description,
            style: TextStyle(fontSize: 17, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}

class NoOfQuestionTile extends StatefulWidget {
  final String text;
  final int number;

  NoOfQuestionTile({required this.text, required this.number});

  @override
  _NoOfQuestionTileState createState() => _NoOfQuestionTileState();
}

class _NoOfQuestionTileState extends State<NoOfQuestionTile> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 3),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(14),
                bottomLeft: Radius.circular(14),
              ),
              color: theme.primaryColor, // Use primary color from the theme
            ),
            child: Text(
              "${widget.number}",
              style: TextStyle(color: Colors.white),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(14),
                bottomRight: Radius.circular(14),
              ),
              color: theme.primaryColor, // Use accent color from the theme
            ),
            child: Text(
              widget.text,
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
     ),);
     }
}