import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LeaderboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Leaderboard'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream:
            FirebaseFirestore.instance.collection('quiz_result').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No leaderboard data available.'));
          }

          final quizResults = snapshot.data!.docs;

          return ListView.builder(
            itemCount: quizResults.length,
            itemBuilder: (context, index) {
              final result = quizResults[index];
              final user = result['user'] ??
                  'Unknown'; // Assuming 'user' is the field storing user information
              final correctAnswers = result['correct_answers'] ?? 0;

              return ListTile(
                title: Text(user),
                subtitle: Text('Correct Answers: $correctAnswers'),
              );
            },
          );
        },
      ),
    );
  }
}
