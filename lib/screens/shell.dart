import 'package:flutter/material.dart';
import '../data/users.dart';
import '../screens/home_screen.dart';

class Shell extends StatefulWidget {
  @override
  _ShellState createState() => _ShellState();
}

class _ShellState extends State<Shell> {
  ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      controller: _scrollController,
      isAlwaysShown: true,
      child: SingleChildScrollView(
        controller: _scrollController,
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