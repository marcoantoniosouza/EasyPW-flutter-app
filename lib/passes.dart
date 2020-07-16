import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'Controller/PassController.dart' as PassController;

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
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.teal),
        title: Text(
          'Senhas',
          style: TextStyle(
            color: Colors.teal,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            color: Colors.teal,
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

class PassesList extends StatelessWidget {
  final List<PassController.Pass> passes;

  PassesList({Key key, this.passes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: passes.length,
      itemBuilder: (context, index) {
        return ListTile(
          trailing: IconButton(
            icon: Icon(Icons.visibility),
            onPressed: () {
              print(passes[index].senha);
            },
          ),
          title: Text(
            passes[index].nome,
          ),
        );
      },
    );
  }
}
