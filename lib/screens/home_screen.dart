import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:reorderable_list_example/models/user.dart';
import '../data/users.dart' show getUsers;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<User> users = [];

  @override
  void initState() {
    super.initState();
    users = getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ReorderableListView.builder(
        onReorder: (oldIndex, newIndex) {
          print('old: $oldIndex new: $newIndex');
          setState(() {
            if (oldIndex < newIndex) {
              newIndex -= 1;
            }
            final user = users.removeAt(oldIndex);
            users.insert(newIndex, user);
          });
        },
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return Card(
            key: ValueKey(user),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                  child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  width: 40.0,
                  height: 40.0,
                  imageUrl: user.imageUrl,
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
              title: Text(user.name),
            ),
          );
        },
      ),
    );
  }
}


