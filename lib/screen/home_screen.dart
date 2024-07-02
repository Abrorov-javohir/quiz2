import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz2/controller/quiz_controller.dart';
import 'package:quiz2/model/quiz.dart';
import 'package:quiz2/screen/leader_board_screen.dart';
import 'package:quiz2/screen/result_screen.dart';
import 'package:quiz2/screen/widgets/page_view_builder.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();
  int _correctAnswers = 0;
  int _incorrectAnswers = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextQuestion(int totalQuestions, bool isCorrect) {
    if (isCorrect) {
      _correctAnswers++;
    } else {
      _incorrectAnswers++;
    }

    if (_pageController.hasClients) {
      if (_pageController.page?.toInt() == totalQuestions - 1) {
        // Navigate to the result screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ResultScreen(
              correctAnswers: _correctAnswers,
              incorrectAnswers: _incorrectAnswers,
              totalQuestions: totalQuestions,
            ),
          ),
        );
      } else {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInCirc,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz App'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return LeaderboardScreen(); // Navigate to the leaderboard screen
              }));
            },
            icon: const Icon(Icons.leaderboard),
          ),
        ],
      ),
      body: SafeArea(
        child: Consumer<QuizController>(
          builder: (context, controller, child) {
            return StreamBuilder<QuerySnapshot>(
              stream: controller.list,
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(
                    child: Text("No quizzes available"),
                  );
                }

                final quizzes = snapshot.data!.docs;
                if (quizzes.isEmpty) {
                  return const Center(
                    child: Text("Error loading quizzes"),
                  );
                }

                final products =
                    quizzes.map((doc) => Quiz.fromJson(doc)).toList();

                return Center(
                  child: PageView.builder(
                    physics:
                        const ScrollPhysics(parent: BouncingScrollPhysics()),
                    itemCount: products.length,
                    controller: _pageController,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      final quiz = products[index];

                      return PageViewBuilder(
                        key: ValueKey(quiz.id),
                        answers: quiz.answers,
                        question: quiz.question,
                        index: index,
                        totalQuestions: products.length,
                        nextQuestion: (bool isCorrect) =>
                            _nextQuestion(products.length, isCorrect),
                        correct: quiz.correct,
                      );
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
