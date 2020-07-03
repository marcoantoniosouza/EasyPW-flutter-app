import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'services/api.dart' as api;
import 'env.dart' as env;

class PassesPage extends StatefulWidget {
  static String tag = 'passes-page';
  @override
  _PassesPageState createState() => new _PassesPageState();
}

class _PassesPageState extends State<PassesPage> {
  final _passes = TextEditingController();

  _apiGetPasses() async {
    api.headers['auth'] = env.authHash;

    await get(api.url + '/passes', headers: api.headers).then((res) {
      setState(() {
        print(res.body);
        _passes.text = res.body;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _apiGetPasses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text(_passes.text),
    );
  }
}
