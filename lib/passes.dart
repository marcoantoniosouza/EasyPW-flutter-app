import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'Controller/PassController.dart' as PassController;

class PassesPage extends StatefulWidget {
  static String tag = 'passes-page';
  @override
  _PassesPageState createState() => new _PassesPageState();
}

class _PassesPageState extends State<PassesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<PassController.Pass>>(
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
        return Text(passes[index].nome);
      },
    );
  }
}
