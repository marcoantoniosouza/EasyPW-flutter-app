import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'Controller/PassController.dart' as PassController;
import 'newpass.dart';

class AddButton extends StatelessWidget {
  _navigateAndShowResponse(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NewPass()),
    );

    if (result == 200) {
      Scaffold.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(SnackBar(
          content: Text("Nova senha cadastrada"),
          backgroundColor: Colors.green,
        ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.add),
      onPressed: () {
        _navigateAndShowResponse(context);
      },
    );
  }
}

class PassesPage extends StatefulWidget {
  static String tag = 'passes-page';

  @override
  _PassesPageState createState() => new _PassesPageState();
}

class _PassesPageState extends State<PassesPage> {
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Senhas',
        ),
        actions: <Widget>[
          AddButton(),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                isLoading = true;
              });
              PassController.getPasses().then((passes) {
                setState(() {
                  isLoading = false;
                });
              });
            },
          ),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : FutureBuilder<List<PassController.Pass>>(
              key: refreshKey,
              future: PassController.getPasses(),
              builder: (context, snapshot) {
                if (snapshot.hasError) print(snapshot.error);

                return snapshot.hasData
                    ? PassesList(
                        passes: snapshot.data,
                      )
                    : Center(child: CircularProgressIndicator());
              },
            ),
    );
  }
}

class PassesList extends StatefulWidget {
  final List<PassController.Pass> passes;

  PassesList({Key key, this.passes}) : super(key: key);

  @override
  _PassesListState createState() => new _PassesListState();
}

class _PassesListState extends State<PassesList> {
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.passes.length,
      itemBuilder: (context, index) {
        final _pass = TextEditingController();
        _pass.text = 'Senha: *******';

        _changeVisibility(index) {
          String text;

          if (_pass.text == 'Senha: *******') {
            text = widget.passes[index].senha;
          } else {
            text = '*******';
          }

          _pass.text = 'Senha: ' + text;
        }

        return Card(
          child: ListTile(
            title: Padding(
                padding: EdgeInsets.all(2),
                child: Text(
                  widget.passes[index].nome,
                )),
            subtitle: TextField(
              controller: _pass,
              enabled: false,
              maxLines: 1,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(0.0),
                isDense: true,
                border: InputBorder.none,
              ),
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.delete),
                  color: Colors.red[300],
                  onPressed: () {
                    PassController.deletePass(widget.passes[index].id)
                        .then(
                          Scaffold.of(context)
                            ..showSnackBar(
                              SnackBar(
                                content: Text("Senha deletada"),
                                backgroundColor: Colors.green,
                              ),
                            ),
                        )
                        .then(PassController.getPasses());
                  },
                ),
                IconButton(
                  icon: Icon(Icons.visibility),
                  onPressed: () {
                    _changeVisibility(index);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
