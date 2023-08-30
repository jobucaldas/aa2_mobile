import 'package:flutter/material.dart';
import 'package:aa2_mobile/persistence/database.dart';
import 'package:aa2_mobile/persistence/consulta.dart';
import 'package:aa2_mobile/skeleton_screen.dart';

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
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            title: Text(snapshot.data![index].specialty,
                                style: TextStyle(
                                  fontSize: 22,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                )),
                            subtitle: Text(
                                'Profissional: ${snapshot.data![index].profissional} \n'
                                'Data: ${snapshot.data![index].date} \n'
                                'Horário: ${snapshot.data![index].time}'),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                DBProvider.db
                                    .deleteConsulta(snapshot.data![index]);
                                setState(() {
                                  widget.consultas =
                                      DBProvider.db.getAllConsultas();
                                });
                              },
                            ),
                          ),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                  return const SkeletonScreen();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
