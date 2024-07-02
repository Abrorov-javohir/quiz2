import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quiz2/model/quiz.dart';
import 'package:quiz2/service/quiz_firebase_service.dart';

class ManageQuestionsScreen extends StatefulWidget {
  const ManageQuestionsScreen({Key? key}) : super(key: key);

  @override
  _ManageQuestionsScreenState createState() => _ManageQuestionsScreenState();
}

class _ManageQuestionsScreenState extends State<ManageQuestionsScreen> {
  final TextEditingController _questionController = TextEditingController();
  final List<TextEditingController> _answerControllers =
      List.generate(4, (_) => TextEditingController());
  final TextEditingController _correctAnswerController =
      TextEditingController();
  final QuizFirebaseService _quizService = QuizFirebaseService();

  @override
  void dispose() {
    _questionController.dispose();
    for (var controller in _answerControllers) {
      controller.dispose();
    }
    _correctAnswerController.dispose();
    super.dispose();
  }

  void _addQuiz() {
    final question = _questionController.text;
    final answers =
        _answerControllers.map((controller) => controller.text).toList();
    final correct = int.tryParse(_correctAnswerController.text) ?? 0;

    if (question.isNotEmpty &&
        answers.every((answer) => answer.isNotEmpty) &&
        correct < answers.length) {
      final quiz = Quiz(
        question: question,
        answers: answers,
        correct: correct,
        id: "2",
      );

      _quizService.addQuiz(quiz).then((_) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Quiz added successfully')));
        _questionController.clear();
        _answerControllers.forEach((controller) => controller.clear());
        _correctAnswerController.clear();
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to add quiz: $error')));
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please fill out all fields')));
    }
  }

  void _deleteQuiz(String id) {
    _quizService.deleteQuiz(id).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Quiz deleted successfully')));
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to delete quiz: $error')));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Questions'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _questionController,
              decoration: const InputDecoration(labelText: 'Question'),
            ),
            ..._answerControllers.map((controller) => TextField(
                  controller: controller,
                  decoration: const InputDecoration(labelText: 'Answer'),
                )),
            TextField(
              controller: _correctAnswerController,
              decoration:
                  const InputDecoration(labelText: 'Correct Answer Index'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addQuiz,
              child: const Text('Add Question'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _quizService.quizzes,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(child: Text('No quizzes available'));
                  }

                  return ListView(
                    children: snapshot.data!.docs.map((doc) {
                      final quiz = Quiz.fromJson(doc);
                      return ListTile(
                        title: Text(quiz.question),
                        subtitle: Text('Correct answer index: ${quiz.correct}'),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => _deleteQuiz(doc.id),
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
