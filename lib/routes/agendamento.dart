import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:aa2_mobile/routes/consultas.dart';

class Agendamento extends StatefulWidget {
  const Agendamento({super.key, required this.title});

  final String title;

  @override
  State<Agendamento> createState() => _AgendamentoState();
}

class _AgendamentoState extends State<Agendamento> {
  void _agendarConsulta() {
    Navigator.push(
      context,
      CupertinoPageRoute(
          builder: (context) => const Consultas(title: 'Consulta')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        centerTitle: true,
        title: Image.asset(
          "images/Logotipo.png",
          width: 140,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Agendamentos:',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _agendarConsulta,
        tooltip: 'Increment',
        child: const Icon(Icons.arrow_forward),
      ),
    );
  }
}
