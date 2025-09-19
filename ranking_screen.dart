import 'package:flutter/material.dart';
import '../db_helper.dart';

class RankingScreen extends StatelessWidget {
  Future<List<Map<String, dynamic>>> _getRanking() async {
    final db = DBHelper.db;
    return await db.rawQuery('''
      SELECT u.username, SUM(s.score) as total
      FROM scores s
      JOIN users u ON s.userId = u.id
      GROUP BY u.id
      ORDER BY total DESC
      LIMIT 5
    ''');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Top 5 Ranking")),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _getRanking(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
          final data = snapshot.data!;
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (_, index) {
              final entry = data[index];
              return ListTile(
                title: Text('${entry['username']}'),
                trailing: Text('${entry['total']} pts'),
              );
            },
          );
        },
      ),
    );
  }
}