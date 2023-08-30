import 'package:flutter/material.dart';
import 'package:aa2_mobile/service/profissionais.dart';
import 'package:aa2_mobile/persistence/database.dart';
import 'package:aa2_mobile/persistence/consulta.dart';
import 'package:aa2_mobile/skeleton_screen.dart';
import 'package:intl/intl.dart';

class Profissionais extends StatefulWidget {
  const Profissionais({super.key});

  @override
  State<Profissionais> createState() => _ProfissionaisState();
}

class _ProfissionaisState extends State<Profissionais> {
  late Future<List<Profissional>> futureProfissionais;

  /*void _agendarProfissional() {
    Navigator.push(
      context,
      CupertinoPageRoute(
          builder: (context) => const Agendamento(title: 'Agendamento')),
    );
  }*/

  @override
  void initState() {
    super.initState();
    futureProfissionais = NetworkManagement().fetchProfissionais();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: Text('Profissionais Disponíveis',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.secondary,
                  )),
            ),
            Expanded(
              child: FutureBuilder<List<Profissional>>(
                future: futureProfissionais,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    //criação dos cards
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 8,
                          margin: const EdgeInsets.all(16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
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
                                  onPressed: () {
                                    pickDateTime(snapshot.data![index].name,
                                        snapshot.data![index].specialty);
                                  },
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
                  return const SkeletonScreen(); //por padrão retorna uma skeleton screen
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future pickDateTime(String profissional, String especialidade) async {
    DateTime? date = await pickDate();
    if (date == null) return; //pressed 'CANCEL'

    TimeOfDay? time = await pickTime();
    if (time == null) return; //pressed 'CANCEL'

    final DateFormat formatter = DateFormat('dd/MM/yyyy');
    final String formattedDate = formatter.format(date);
    final String formattedTime =
        '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';

    // Insert new consulta into database
    DBProvider.db.insertNewConsulta(Consulta(
      id: DateTime.now().toString(),
      profissional: profissional,
      specialty: especialidade,
      date: formattedDate,
      time: formattedTime,
    ));
  }

  Future<DateTime?> pickDate() => showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2023),
        lastDate: DateTime(2030),
      );

  Future<TimeOfDay?> pickTime() =>
      showTimePicker(context: context, initialTime: TimeOfDay.now());
}
