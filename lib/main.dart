import 'package:flutter/material.dart';
import 'package:weath_app/pages/home..dart';
import 'package:weath_app/pages/welcome.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WelcomePage(),
     
    );
  }
}
