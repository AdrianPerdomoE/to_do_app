import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'widgets/main_scaffold.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp().then((value) => runApp(const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromRGBO(20, 25, 39, 0 - 6)),
        scaffoldBackgroundColor: const Color.fromRGBO(23, 27, 42, 0.9),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromRGBO(40, 39, 37, 1),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color.fromRGBO(30, 29, 37, 1),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const MainScaffold(),
    );
  }
}
