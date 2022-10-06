// @dart=2.9

import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter_application_proyectovariante1/innovando/menu.dart';

import 'package:flutter_application_proyectovariante1/pages/homePage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "home",
      routes: {
        "home": (BuildContext context) => MenuPagina(),
        // "lista": (BuildContext context) => ListaImagenes(),
      },
    );
  }
}
