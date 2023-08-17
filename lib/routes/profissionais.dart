import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:aa2_mobile/routes/agendamento.dart';

class Profissionais extends StatefulWidget {
  const Profissionais({super.key, required this.title});

  final String title;

  @override
  State<Profissionais> createState() => _ProfissionaisState();
}

class _ProfissionaisState extends State<Profissionais> {
  void _agendarProfissional() {
    Navigator.push(
      context,
      CupertinoPageRoute(
          builder: (context) => const Agendamento(title: 'Agendamento')),
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
              'Profissionais disponíveis: ',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _agendarProfissional,
        tooltip: 'Agendar',
        child: const Icon(Icons.arrow_forward),
      ),
    );
  }
}
