import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'services/api.dart' as api;
import 'env.dart' as env;

class LoginPage extends StatefulWidget {
  static String tag = 'login-page';
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _user = TextEditingController();
  final _pass = TextEditingController();

  _loginApi() async {
    String json = '{ "user": "' +
        _user.text +
        '", "pass": "' +
        _pass.text +
        '" }'; // make POST request

    Response response = await post(api.url, headers: api.headers, body: json);

    if (response.statusCode == 200) {
      Map<String, dynamic> res = jsonDecode(response.body);
      _showDialog(res['authHash']);
      env.authHash = res['authHash'];
      /*Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SecondRoute()),
      );*/
    } else {
      _showDialog('Falha no login');
    }
  }

  void _showDialog(messageText) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // retorna um objeto do tipo Dialog
        return AlertDialog(
          title: new Text("Login"),
          content: new Text(messageText),
          actions: <Widget>[
            // define os botões na base do dialogo
            new FlatButton(
              child: new Text("Fechar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  final loginHeader = Text('INICIAR SESSÃO!');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            loginHeader,
            SizedBox(height: 48.0),
            TextFormField(
              controller: _user,
              decoration: InputDecoration(
                hintText: 'Usuário',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0)),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.0),
            TextFormField(
              controller: _pass,
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Senha',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0)),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.0),
            RaisedButton(
              onPressed: _loginApi,
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
