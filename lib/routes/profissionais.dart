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
      Expanded(
        child: FutureBuilder<List<Profissional>>(
          future: futureProfissionais,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              // Use ListView.builder para criar os Cards diretamente
              return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.all(16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),),
                    child: ListTile(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'images/${snapshot.data![index].imageId}.png',
                            width: 200,
                            height: 150,
                          ),
                          Text(
                            snapshot.data![index].name,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            snapshot.data![index].specialty,
                            style: const TextStyle(fontSize: 16),
                          ),
                          ElevatedButton(
                            onPressed: _agendarProfissional,
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 10,
                              ),
                              backgroundColor:
                                  Theme.of(context).colorScheme.secondary,
                              textStyle: const TextStyle(fontSize: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: const Text('Agendar'),
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
      
            // Por padrão, mostre um spinner de carregamento.
            return const Align( //usando o Align e SizedBox pois o spinner estava esticando verticalmente
              alignment: Alignment.center,
              child: SizedBox(
                height: 40,
                child: CircularProgressIndicator(),
              ),
            );
          },
        ),
      ),
    ],
  ),
),
    );
  }
}
