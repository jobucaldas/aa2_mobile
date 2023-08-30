class Consulta {
  final String id;
  final String profissional;
  final String specialty;
  final String date;
  final String time;

  Consulta({
    required this.id,
    required this.profissional,
    required this.specialty,
    required this.date,
    required this.time,
  });

  factory Consulta.fromMap(Map<String, dynamic> map) {
    return Consulta(
      id: map['id'],
      profissional: map['profissional'],
      specialty: map['specialty'],
      date: map['date'],
      time: map['time'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'profissional': profissional,
      'specialty': specialty,
      'date': date,
      'time': time,
    };
  }
}
