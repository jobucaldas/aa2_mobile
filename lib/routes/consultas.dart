import 'package:flutter/material.dart';

class Consultas extends StatefulWidget {
  const Consultas({super.key, required this.title});

  final String title;

  @override
  State<Consultas> createState() => _ConsultasState();
}

class _ConsultasState extends State<Consultas> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Consultas',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
    );
  }
}
