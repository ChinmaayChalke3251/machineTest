import 'package:flutter/material.dart';
import 'package:machine_test/screens/testList.dart';

void main() {
  runApp(MaterialApp(
  title: 'Machine Test',
    theme: ThemeData(
        primaryColor: Colors.blue, accentColor: Colors.yellowAccent),
    debugShowCheckedModeBanner: false,
    home: testList(),
  ));
}




