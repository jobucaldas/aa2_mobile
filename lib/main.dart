import 'package:flutter/material.dart';
import 'package:aa2_mobile/routes/profissionais.dart';
import 'package:aa2_mobile/routes/agendamento.dart';
import 'package:aa2_mobile/routes/consultas.dart';

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
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 69, 123, 157)),
        useMaterial3: true,
      ),
      home: const Profissionais(title: 'Página de profissionais'),
    );
  }
}
