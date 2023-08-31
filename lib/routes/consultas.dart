import 'package:flutter/material.dart';
import 'package:aa2_mobile/persistence/database.dart';
import 'package:aa2_mobile/persistence/consulta.dart';

// ignore: must_be_immutable
class Consultas extends StatefulWidget {
  Consultas({super.key});

  Future<List<Consulta>> consultas = DBProvider.db.getAllConsultas();

  @override
  State<Consultas> createState() => _ConsultasState();
}

class _ConsultasState extends State<Consultas> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: Text('Consultas',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.secondary,
                  )),
            ),
            Expanded(
              // Draw cards with content from database consulta table
              child: FutureBuilder<List<Consulta>>(
                future: widget.consultas,
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 8,
                          margin: const EdgeInsets.only(
                              right: 16, left: 16, bottom: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: ListTile(
                            title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${snapshot.data![index].date},  ${snapshot.data![index].time}',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                    ),
                                  ),
                                  Text(
                                    snapshot.data![index].profissional,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(snapshot.data![index].specialty,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                      )),
                                  const SizedBox(height: 8),
                                ]),
                            subtitle: Center(
                              child: ElevatedButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('Cancelar consulta'),
                                        content: const Text(
                                            'Tem certeza que deseja cancelar a consulta?'),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('Não'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              DBProvider.db.deleteConsulta(
                                                  snapshot.data![index]);
                                              setState(() {
                                                widget.consultas = DBProvider.db
                                                    .getAllConsultas();
                                              });
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('Sim'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  fixedSize: const Size(120, 45),
                                  backgroundColor:
                                      Theme.of(context).colorScheme.secondary,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.free_cancellation),
                                    SizedBox(width: 5),
                                    Text('Cancelar',
                                        style: TextStyle(fontSize: 12)),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  } else {
                    return const Center(
                      child: Text(
                        "Suas consultas aparecerão aqui",
                        style: TextStyle(fontSize: 20),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
