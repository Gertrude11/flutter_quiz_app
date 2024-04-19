import 'package:flutter/material.dart';

Widget appBar(BuildContext context){
  return RichText(
  text: TextSpan(
    style: TextStyle(fontSize: 23),
    children: const <TextSpan>[
      TextSpan(text: 'Do', style: TextStyle( fontSize: 30, fontWeight: FontWeight.w600, color: Colors.black54,backgroundColor: Color.fromARGB(255, 10, 122, 150))),
      TextSpan(text: 'Quiz', style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,  color: Color.fromARGB(255, 245, 80, 30),backgroundColor: Color.fromARGB(255, 10, 122, 150))),
    ],
  ),
);
}

Widget blueButton({required BuildContext context, required String label, buttonWidth,}){
  return  Container(
    padding: EdgeInsets.symmetric(vertical: 18),
    decoration: BoxDecoration(
      color: Colors.blue,
      borderRadius: BorderRadius.circular(16),
    ),
    alignment: Alignment.center,
    width: buttonWidth != null ? buttonWidth : MediaQuery.of(context).size.width -48,
    child: Text(label, style: TextStyle(color: Colors.white,fontSize: 16)
          ),
    );
}