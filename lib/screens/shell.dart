import 'package:flutter/material.dart';
import '../data/users.dart';
import '../screens/home_screen.dart';

class Shell extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(child: HomeScreen(data: getUsers(), title: 'To Do', columnId: '1',)),
          const SizedBox(width: 16.0,),
          Expanded(child: HomeScreen(data: getUsers(),title: 'In Progress', columnId: '2',), ),
          const SizedBox(width: 16.0,),
          Expanded(child: HomeScreen(data: getUsers(isDone: true), title: 'Done', columnId: '3',)),
        ],
      ),
    );
  }
}