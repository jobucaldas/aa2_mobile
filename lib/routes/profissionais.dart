import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:aa2_mobile/service/profissionais.dart';
import 'package:aa2_mobile/skeleton_screen.dart';

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
               child: Text(
                'Profissionais disponíveis',
                style: TextStyle(
                  fontSize: 28, 
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.secondary,
                )
                         ),
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
                          elevation: 8,
                          margin: const EdgeInsets.all(16),
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
                                  onPressed: pickDateTime,
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
                  return SkeletonScreen();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future pickDateTime() async {
    DateTime? date = await pickDate();
    if(date == null) return; //pressed 'CANCEL'

    TimeOfDay? time = await pickTime();
    if(time == null) return; //pressed 'CANCEL'
  }

  Future<DateTime?> pickDate() => showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2023),
    lastDate: DateTime(2030),
  );

  Future<TimeOfDay?> pickTime() => showTimePicker(
    context: context, 
    initialTime: TimeOfDay.now()
    );
}
