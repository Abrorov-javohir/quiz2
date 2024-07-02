import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quiz2/model/quiz.dart';

class QuizFirebaseService {
  final CollectionReference quizCollection = FirebaseFirestore.instance.collection('quiz');

  Stream<QuerySnapshot> get quizzes => quizCollection.snapshots();

  Future<void> addQuiz(Quiz quiz) {
    return quizCollection.add(quiz.toJson());
  }

  Future<void> deleteQuiz(String id) {
    return quizCollection.doc(id).delete();
  }
}
