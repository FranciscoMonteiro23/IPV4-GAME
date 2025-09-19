import 'package:flutter/material.dart';
import 'question_screen.dart';
import 'score_screen.dart';
import 'ranking_screen.dart';

class HomeScreen extends StatelessWidget {
  final int userId;
  final String username;

  const HomeScreen({required this.userId, required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Bem-vindo, $username')),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Text("Escolha o nível de dificuldade:", style: TextStyle(fontSize: 18)),
            ElevatedButton(onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (_) => QuestionScreen(userId: userId, level: 1),
              ));
            }, child: Text("Nível 1")),
            ElevatedButton(onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (_) => QuestionScreen(userId: userId, level: 2),
              ));
            }, child: Text("Nível 2")),
            ElevatedButton(onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (_) => QuestionScreen(userId: userId, level: 3),
              ));
            }, child: Text("Nível 3")),
            SizedBox(height: 20),
            ElevatedButton(onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => ScoreScreen(userId: userId)));
            }, child: Text("Ver Score")),
            ElevatedButton(onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => RankingScreen()));
            }, child: Text("Ver Ranking")),
          ],
        ),
      ),
    );
  }
}