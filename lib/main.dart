import 'package:flutter/material.dart';
import 'Inicio.dart';
void main ()
{
  runApp(new BlogApp());
}

class BlogApp extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return new MaterialApp
      (
        title: "Galeria Personal",
        theme: new ThemeData
          (
            primarySwatch: Colors.purple,
          ),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      );
  }
}