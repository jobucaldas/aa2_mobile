import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Profissional {
  final int id;
  final String name;
  final String specialty;
  final String imageId;

  Profissional(
      {required this.id,
      required this.name,
      required this.specialty,
      required this.imageId});

  // Populate with data from json
  factory Profissional.fromJson(Map<String, dynamic> json) {
    return Profissional(
      id: json['id'] as int,
      name: json['name'] as String,
      specialty: json['speciality'] as String,
      imageId: json['imageId'] as String,
    );
  }
}

class NetworkManagement {
  Future<List<Profissional>> fetchProfissionais() async {
    final response = await http.get(Uri.parse(
        'https://my-json-server.typicode.com/lvizfernando/jsonserver/profissionais'));

    // Log response
    if (kDebugMode) {
      print(response.body);
    }

    return parseProfissionais(response.body);
  }

  // Parse profissionais as list and prints each one
  List<Profissional> parseProfissionais(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

    return parsed
        .map<Profissional>((json) => Profissional.fromJson(json))
        .toList();
  }
}
