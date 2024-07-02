import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz2/controller/quiz_controller.dart';
import 'package:quiz2/firebase_options.dart';
import 'package:quiz2/screen/home_screen.dart';
import 'package:quiz2/screen/login_screen.dart';
import 'package:quiz2/screen/start_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => QuizController(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasData) {
              return const HomeScreen(); // Foydalanuvchi autentifikatsiyalangan bo'lsa, HomeScreen qaytaradi
            }
            return const LoginScreen(); // Foydalanuvchi autentifikatsiyalanmagan bo'lsa, LoginScreen qaytaradi
          },
        ),
        routes: {
          '/start': (context) => const StartScreen(),
          '/home': (context) => const HomeScreen(),
          '/login': (context) => const LoginScreen(),
        },
      ),
    );
  }
}
