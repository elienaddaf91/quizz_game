import 'package:flutter/material.dart';
import 'package:quizz_game/level_screen.dart';
import 'package:quizz_game/models/quiz_question.dart';

import 'package:quizz_game/start_screen.dart';
import 'package:quizz_game/questions_screen.dart';
import 'package:quizz_game/results_screen.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() {
    return _QuizState();
  }
}

class _QuizState extends State<Quiz> {
  List<QuizQuestion> _quizzQuestions = [];

  String level = "1";
  var _activeScreen = 'start-screen';

  void _switchScreen() {
    setState(() {
      _activeScreen = 'select-level';
    });
  }

  void _selectLevel(String level){
    this.level = level;

    setState(() {
      _activeScreen = 'questions-screen';
    });
  }

  void _chooseAnswer(QuizQuestion quizzQuestion) {
    _quizzQuestions.add(quizzQuestion);

    if (_quizzQuestions.length == 5) {
      setState(() {
        _activeScreen = 'results-screen';
      });
    }
  }

  void restartQuiz() {
    setState(() {
      _quizzQuestions = [];
      _activeScreen = 'select-level';
    });
  }

  @override
  Widget build(context) {
    Widget screenWidget = StartScreen(_switchScreen);

    if (_activeScreen == 'questions-screen') {
      screenWidget = QuestionsScreen(
        level: level,
        onSelectAnswer: _chooseAnswer,
      );
    }

    if (_activeScreen == 'select-level') {
      screenWidget = LevelScreen(
        onSelectLevel: _selectLevel,
      );
    }

    if (_activeScreen == 'results-screen') {
      screenWidget = ResultsScreen(
        level: level,
        quizzQuestions: _quizzQuestions,
        onRestart: restartQuiz,

      );
    }

    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 78, 13, 151),
                Color.fromARGB(255, 107, 15, 168),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: screenWidget,
        ),
      ),
    );
  }
}
