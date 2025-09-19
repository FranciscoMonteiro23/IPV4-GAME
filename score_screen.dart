import 'package:flutter/material.dart';
import '../db_helper.dart';

class ScoreScreen extends StatelessWidget {
  final int userId;

  const ScoreScreen({required this.userId});

  Future<int> _getScore() async {
    final db = DBHelper.db;
    final result = await db.rawQuery('SELECT SUM(score) as total FROM scores WHERE userId = ?', [userId]);
    return result.first['total'] == null ? 0 : result.first['total'] as int;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Seu Score")),
      body: FutureBuilder<int>(
        future: _getScore(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
          return Center(
            child: Text("Seu score atual: ${snapshot.data} pontos", style: TextStyle(fontSize: 22)),
          );
        },
      ),
    );
  }
}