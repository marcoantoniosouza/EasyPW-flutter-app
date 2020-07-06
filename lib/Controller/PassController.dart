import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'dart:convert';

import '../services/api.dart' as api;
import '../env.dart' as env;

List<Pass> parsePasses(String responseBody) {
  final parsedList = json.decode(responseBody).cast<Map<String, dynamic>>();

  return parsedList.map<Pass>((pass) => Pass.fromJson(pass)).toList();
}

Future<List<Pass>> getPasses() async {
  api.headers['auth'] = env.authHash;

  final response = await get(api.url + '/passes', headers: api.headers);

  return compute(parsePasses, response.body);
}

class Pass {
  final String id;
  final String nome;
  final String senha;

  Pass({this.id, this.nome, this.senha});

  factory Pass.fromJson(Map<String, dynamic> json) {
    return Pass(
      id: json['id'] as String,
      nome: json['nome'] as String,
      senha: json['pass'] as String,
    );
  }
}
