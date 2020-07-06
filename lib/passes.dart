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
      ),
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
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                width: double.infinity,
                height: 50,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.teal[200],
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: Text(
                            passes[index].nome,
                            style: TextStyle(
                              color: Colors.grey[200],
                              fontSize: 20,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.visibility,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            print('Pressed');
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
