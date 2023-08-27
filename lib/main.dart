import 'package:flutter/material.dart';
import 'package:aa2_mobile/routes/profissionais.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AA2',
      theme: ThemeData(
        colorScheme: const ColorScheme.light().copyWith(
        primary: const Color.fromARGB(255, 69, 123, 157),
        secondary: const Color(0xFF1D3557),
        ),
      ),
      home: const Profissionais(
        title: 'Página de profissionais'
        ),
    );
  }
}
