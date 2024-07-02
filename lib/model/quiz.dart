import 'package:cloud_firestore/cloud_firestore.dart';

class Quiz {
  final String id;
  final String question;
  final List<String> answers;
  final int correct;

  Quiz({
    required this.id,
    required this.question,
    required this.answers,
    required this.correct,
  });

  Map<String, dynamic> toJson() {
    return {
      'question': question,
      'answers': answers,
      'correct': correct,
    };
  }

  factory Quiz.fromJson(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Quiz(
      id: doc.id,
      question: data['question'] as String,
      answers: List<String>.from(data['answers']),
      correct: data['correct'] as int,
    );
  }
}
