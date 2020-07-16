import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'dart:convert';

import '../Service/apiService.dart' as apiService;
import '../env.dart' as env;

List<Pass> parsePasses(String responseBody) {
  final parsedList = json.decode(responseBody).cast<Map<String, dynamic>>();

  return parsedList.map<Pass>((pass) => Pass.fromJson(pass)).toList();
}

Future<List<Pass>> getPasses() async {
  apiService.headers['auth'] = env.authHash;

  final response =
      await get(apiService.url + '/passes', headers: apiService.headers);

  return compute(parsePasses, response.body);
}

newPass(String newNome, String newPass) async {
  print('newPass');
  apiService.headers['auth'] = env.authHash;

  final response = await post(
    apiService.url + '/passes',
    headers: apiService.headers,
    body: jsonEncode(<String, String>{'nome': newNome, 'pass': newPass}),
  );

  print(response.statusCode);

  return response.statusCode;
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
