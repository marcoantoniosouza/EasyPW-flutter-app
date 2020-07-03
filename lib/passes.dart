import 'package:flutter/material.dart';
import 'env.dart' as env;

class PassesPage extends StatefulWidget {
  static String tag = 'passes-page';
  @override
  _PassesPageState createState() => new _PassesPageState();
}

class _PassesPageState extends State<PassesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text(env.authHash),
    );
  }
}
