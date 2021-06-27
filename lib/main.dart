import 'package:flutter/material.dart';
import './screens/screens.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        canvasColor: Colors.white,
      ),
      title: 'Flutter Kanban',
      home: Scaffold(
        
        appBar: AppBar(
          title: Text('Flutter Kanban'),
        ),
        body: Shell(),
        // body: HomeScreen(),
      ),
    );
  }
}
