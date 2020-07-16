import 'package:flutter/material.dart';

import 'Controller/PassController.dart' as PassController;

class NewPass extends StatefulWidget {
  @override
  _NewPassState createState() => _NewPassState();
}

class _NewPassState extends State<NewPass> {
  final _newNome = TextEditingController();
  final _newPass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nova Senha'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _newNome,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  hintText: 'Nome',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0)),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8.0),
              TextFormField(
                controller: _newPass,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  hintText: 'Senha',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0)),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8.0),
              MaterialButton(
                onPressed: () {
                  print(_newNome.text);
                  print(_newPass.text);
                  PassController.newPass(_newNome.text, _newPass.text).then(
                      (statusCode) => {Navigator.pop(context, statusCode)});
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                padding: EdgeInsets.all(12),
                color: Colors.teal,
                minWidth: double.infinity,
                height: 58,
                child: Text(
                  'Cadastrar',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
