import 'package:flutter/material.dart';
import '../data/users.dart';
import '../screens/home_screen.dart';

class Shell extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      // isAlwaysShown: true,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
         padding: const EdgeInsets.all(16.0),
         child: Row(
           children: [
             HomeScreen(data: getUsers(), title: 'To Do', columnId: '1',),
             const SizedBox(width: 16.0,),
             HomeScreen(data: getUsers(),title: 'In Progress', columnId: '2',),
             const SizedBox(width: 16.0,),
             HomeScreen(data: getUsers(isDone: true), title: 'Done', columnId: '3',),
           ],
         ),
        ),
      ),
    );
  }
}