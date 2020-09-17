import 'package:flutter/material.dart';
import 'package:iknoweverything/pages/qa.dart';

void main() {
  runApp(IKnowEveryThing());
}

class IKnowEveryThing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.amber),
      debugShowCheckedModeBanner: false,
      title: "I Know Everything",
      home: Qapge(),
    );
      
    
  }
}