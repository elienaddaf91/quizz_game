class QuizQuestion {
  QuizQuestion(this.text, this.answers, this.correctAnswer);

  final String text;
  final List<String> answers;
  final String correctAnswer;
  String? userAnswer;

  List<String> get shuffledAnswers {
    final shuffledList = List.of(answers);
    shuffledList.shuffle();
    return shuffledList;
  }
}
