import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'login.dart';
import 'passes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final routes = <String, WidgetBuilder>{
    LoginPage.tag: (context) => LoginPage(),
    PassesPage.tag: (context) => PassesPage(),
  };

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            FocusScope.of(context).requestFocus(new FocusNode());
          }
        },
        child: MaterialApp(
          title: 'EasyPW',
          theme: ThemeData(
            textTheme: GoogleFonts.robotoTextTheme(
              Theme.of(context).textTheme,
            ),
            primarySwatch: Colors.teal,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: LoginPage(),
        ));
  }
}
