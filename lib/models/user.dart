import 'package:flutter/material.dart';

class User {
  final String name;
  String imageUrl;
  Color color;
  bool isDone;

  User({
    @required this.name,
    @required this.imageUrl,
    this.color = Colors.grey,
    this.isDone = false,
  });
}

class MovingUser extends User {
  int index;
  String columnId;

  MovingUser({
    String name,
    String imageUrl,
    bool isDone,
    Color color,
    this.index,
    this.columnId
  }) : super(name: name, imageUrl: imageUrl);
}
