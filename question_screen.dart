import 'package:flutter/material.dart';
import '../question_service.dart';
import '../db_helper.dart';
import 'home_screen.dart';

class QuestionScreen extends StatefulWidget {
  final int userId;
  final int level;

  QuestionScreen({required this.userId, required this.level});

  @override
  _QuestionScreenState createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  late IPv4Question _question;
  final _controller = TextEditingController();
  String _feedback = '';
  int _scoreChange = 0;

  @override
  void initState() {
    super.initState();
    _question = QuestionService.generate(widget.level);
  }

  void _submit() async {
    final answer = _controller.text.trim().toLowerCase();
    final correct = _question.correctAnswer.toLowerCase();
    bool isCorrect = answer == correct;
    int scoreDelta = 0;
    switch (widget.level) {
      case 1: scoreDelta = isCorrect ? 10 : -5; break;
      case 2: scoreDelta = isCorrect ? 20 : -10; break;
      case 3: scoreDelta = isCorrect ? 30 : -15; break;
    }
    final db = DBHelper.db;
    await db.insert('scores', {
      'userId': widget.userId,
      'score': scoreDelta,
      'datetime': DateTime.now().toIso8601String(),
    });

    setState(() {
      _feedback = isCorrect ? 'Correto! +$scoreDelta pontos.' : 'Errado. Resposta correta: $correct. ($scoreDelta pontos)';
      _scoreChange = scoreDelta;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Pergunta - Nível ${widget.level}")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(_question.question, style: TextStyle(fontSize: 18)),
            TextField(controller: _controller, decoration: InputDecoration(labelText: "Sua resposta")),
            SizedBox(height: 10),
            ElevatedButton(onPressed: _submit, child: Text("Responder")),
            if (_feedback.isNotEmpty) Text(_feedback, style: TextStyle(fontSize: 16, color: Colors.green)),
            if (_feedback.isNotEmpty)
              ElevatedButton(onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (_) => HomeScreen(userId: widget.userId, username: ''),
                ));
              }, child: Text("Voltar ao início")),
          ],
        ),
      ),
    );
  }
}