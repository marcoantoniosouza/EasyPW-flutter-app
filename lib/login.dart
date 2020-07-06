import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'passes.dart';

import 'Service/apiService.dart' as apiService;
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

    Response response = await post(apiService.url + '/login',
        headers: apiService.headers, body: json);

    if (response.statusCode == 200) {
      Map<String, dynamic> res = jsonDecode(response.body);
      //_showDialog(res['authHash']);
      env.authHash = res['authHash'];
      //Navigator.of(context).pushNamed(PassesPage.tag);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PassesPage()),
      );
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

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  final loginHeader = Column(children: <Widget>[
    Icon(
      Icons.lock,
      color: Colors.teal,
      size: 100,
    )
  ]);

  @override
  Widget build(BuildContext context) {
    final FocusNode _userFocus = FocusNode();
    final FocusNode _passFocus = FocusNode();

    return Scaffold(
        backgroundColor: Colors.grey[200],
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                loginHeader,
                SizedBox(height: 48.0),
                TextFormField(
                  controller: _user,
                  textInputAction: TextInputAction.next,
                  focusNode: _userFocus,
                  onFieldSubmitted: (term) {
                    _fieldFocusChange(context, _userFocus, _passFocus);
                  },
                  decoration: InputDecoration(
                    hintText: 'Usuário',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0)),
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8.0),
                TextFormField(
                  showCursor: false,
                  controller: _pass,
                  textInputAction: TextInputAction.done,
                  focusNode: _passFocus,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Senha',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0)),
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8.0),
                Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    child: MaterialButton(
                      onPressed: _loginApi,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      padding: EdgeInsets.all(12),
                      color: Colors.teal,
                      minWidth: double.infinity,
                      height: 58,
                      child: Text(
                        'Entrar',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    )),
              ],
            ),
          ),
        ));
  }
}
