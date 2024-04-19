
class Question{
  late String question;
  late String option1;
  late String option2;
  late String option3;
  late String option4;
  late String correctOption;
  late bool answered;

  //  Question({
  //   required this.question,
  //   required this.option1,
  //   required this.option2,
  //   required this.option3,
  //   required this.option4,
  //   required this.correctOption,
  // });
  //   factory Question.fromSnapshot(DocumentSnapshot snapshot) {
  //   return Question(
  //     question: snapshot['question'] ?? '',
  //     option1: snapshot['option1'] ?? '',
  //     option2: snapshot['option2'] ?? '',
  //     option3: snapshot['option3'] ?? '',
  //     option4: snapshot['option4'] ?? '',
  //     correctOption: snapshot['correctOption'] ?? '',
  //   );
  // }
}