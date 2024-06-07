import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:math_expressions/math_expressions.dart';

import 'package:quizz_game/answer_button.dart';
import 'package:quizz_game/models/quiz_question.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({
    super.key,
    required this.level,
    required this.onSelectAnswer,
  });

  final void Function(QuizQuestion quizzQuestion) onSelectAnswer;
  final String level;

  @override
  State<QuestionsScreen> createState() {
    return _QuestionsScreenState();
  }
}


class _QuestionsScreenState extends State<QuestionsScreen> {

  void answerQuestion(QuizQuestion quizQuestion) {
    widget.onSelectAnswer(quizQuestion);
    setState(() {

    });
  }

  @override
  Widget build(context) {
    Random random = Random();

    int number1 = random.nextInt(100);
    int number2 = random.nextInt(100);
    String level = widget.level;
    if ((level == '-' || level=='/') && number2 > number1){
      int number3 = number1;
      number1 = number2;
      number2= number3;
    }

      String question = "$number1 $level $number2";

    Parser p = Parser();
    Expression exp = p.parse(question);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    List<String> answers = [];
    String correctAnswer;
    if (level == '/'){
      correctAnswer = eval.toStringAsFixed(2);
      answers.add(correctAnswer);
      answers.add((random.nextDouble() * 99.0).roundToDouble().toStringAsFixed(2));
      answers.add((random.nextDouble() * 9.0).roundToDouble().toStringAsFixed(2));
      answers.add((random.nextDouble() * 99.0).roundToDouble().toStringAsFixed(2));
    }
    else{
      correctAnswer = eval.toString();
      answers.add(correctAnswer);
      answers.add((random.nextInt(1000)).toString());
      answers.add((random.nextInt(100)).toString());
      answers.add((random.nextInt(1000)).toString());
    }

    QuizQuestion quizQuestion = QuizQuestion(question, answers, correctAnswer);

    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              quizQuestion.text,
              style: GoogleFonts.lato(
                color: const Color.fromARGB(255, 201, 153, 251),
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            ...quizQuestion.shuffledAnswers.map((answer) {
              return AnswerButton(
                answerText: answer,
                onTap: () {
                  quizQuestion.userAnswer = answer;
                  answerQuestion(quizQuestion);
                },
              );
            })
          ],
        ),
      ),
    );
  }
}
