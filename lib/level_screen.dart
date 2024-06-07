import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quizz_game/answer_button.dart';

class LevelScreen extends StatefulWidget{
  const LevelScreen({
    super.key,
    required this.onSelectLevel,
  });

  final void Function(String answer) onSelectLevel;

  @override
  State<LevelScreen> createState() {
    return _LevelScreenState();
  }
}

class _LevelScreenState extends State<LevelScreen> {

  List<String> levels = ["+","-","/","*"];

  void selectLevel(String selectedAnswer) {
    widget.onSelectLevel(selectedAnswer);
    // currentQuestionIndex = currentQuestionIndex + 1;
    // currentQuestionIndex += 1;
    setState(() {
    });
  }

  @override
  Widget build(context) {
    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Choose Operator",
              style: GoogleFonts.lato(
                color: const Color.fromARGB(255, 201, 153, 251),
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            ...levels.map((answer) {
              return AnswerButton(
                answerText: answer,
                onTap: () {
                  selectLevel(answer);
                },
              );
            })
          ],
        ),
      ),
    );

  }
}