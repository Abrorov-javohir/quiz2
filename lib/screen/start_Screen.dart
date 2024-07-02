import 'package:flutter/material.dart';
import 'package:quiz2/screen/profile_screen.dart';
import 'package:quiz2/screen/home_screen.dart';
import 'package:quiz2/screen/manage_question_screen.dart';
import 'package:quiz2/screen/result_screen.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          CircleAvatar(
            child: InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ProfileScreen();
                }));
              },
              child: Image.network(
                  width: 100,
                  height: 100,
                  "https://tricky-photoshop.com/wp-content/uploads/2017/08/final-1.png"),
            ),
          )
        ],
      ),
      body: Center(
        child: FilledButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return HomeScreen();
                },
              ),
            );
          },
          child: TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return HomeScreen();
                  },
                ),
              );
            },
            child: const Text(
              "Start Quiz",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
