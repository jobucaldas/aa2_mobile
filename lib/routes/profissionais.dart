import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:aa2_mobile/routes/agendamento.dart';
import 'package:aa2_mobile/service/profissionais.dart';

class Profissionais extends StatefulWidget {
  const Profissionais({super.key, required this.title});

  final String title;

  @override
  State<Profissionais> createState() => _ProfissionaisState();
}

class _ProfissionaisState extends State<Profissionais> {
  late Future<List<Profissional>> futureProfissionais;

  void _agendarProfissional() {
    Navigator.push(
      context,
      CupertinoPageRoute(
          builder: (context) => const Agendamento(title: 'Agendamento')),
    );
  }

  @override
  void initState() {
    super.initState();
    futureProfissionais = NetworkManagement().fetchProfissionais();
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
            FutureBuilder<List<Profissional>>(
              future: futureProfissionais,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  // For each profissional in list, draw card with data
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          leading: Image.asset(
                              'images/${snapshot.data![index].imageId}.png'),
                          title: Text(snapshot.data![index].name),
                          subtitle: Text(snapshot.data![index].specialty),
                        ),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }

                // By default, show a loading spinner.
                return const CircularProgressIndicator();
              },
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
