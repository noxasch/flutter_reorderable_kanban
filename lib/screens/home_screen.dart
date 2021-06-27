import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:reorderable_list_example/models/user.dart';
import '../data/users.dart' show getUsers;

class HomeScreen extends StatefulWidget {
  final List<User> data;
  final String title;
  final String columnId;

  const HomeScreen({
    Key key, 
    @required this.data, 
    @required this.title,
    @required this.columnId,
  }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<User> users;
  // MovingUser _moveUser; // need to use state management to share across widgets
  // index
  // originalColumn

  @override
  void initState() {
    super.initState();
    users = widget.data;
    // users = getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return DragTarget<User>(
      // onAccept: (user) {
      //   setState(() {
      //     // users.add(user)
      //   });
      // },
      onLeave: (data) {
        // final User user = data as User;
        // final index = users.indexOf(user);
        // _moveUser = MovingUser(
        //   name: user.name,
        //   imageUrl: user.imageUrl,
        //   color: user.color,
        //   isDone: user.isDone,
        //   columnId: widget.columnId,
        //   index: index,
        // print(user.name);
        // );
        users.remove(data);
      },
      onAcceptWithDetails:(details) {
        // print('dx: ${details.offset.dx}');
        // print('dy: ${details.offset.dy}');
        if (!users.contains(details.data))
          users.insert(0, details.data);
        // _moveUser = null;
      },
      builder: (context, candidateData, rejectedData) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(widget.title),
            SizedBox(height: 16.0,),
            Expanded(
                child: _ListColumn(
                users: users,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _ListColumn extends StatefulWidget {

  final List<User> users;

  const _ListColumn({
    Key key, 
    @required this.users, 
  }) : super(key: key);

  @override
  __ListColumnState createState() => __ListColumnState();
}

class __ListColumnState extends State<_ListColumn> {
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // _scrollController.position.context.notificationContext.findRenderObject()
    return Container(
      // color: Colors.blue,
      width: 355.0,
      constraints: BoxConstraints(
        maxWidth: 355.0
      ),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.grey[300],
            blurRadius: 3.0,
            offset: Offset(-1.0, 0),
          ),
        ],
        borderRadius: BorderRadius.circular(5.0)
      ),
      child: ReorderableList(
        controller: _scrollController,
        // buildDefaultDragHandles: false,
        onReorder: (oldIndex, newIndex) {
          print('old: $oldIndex new: $newIndex');
          setState(() {
            if (oldIndex < newIndex) {
              newIndex -= 1;
            }
            final user = widget.users.removeAt(oldIndex);
            widget.users.insert(newIndex, user);
          });
        },
        itemCount: widget.users.length,
        itemBuilder: (context, index) {
          final user = widget.users[index];
          return _ListItem(
            key: ValueKey(user),
            data: user,
            index: index,
            child: CustomItem(
              index: index,
              user: user
            ),
          );
          // return _ListItem(
          //   key: ValueKey(user), 
          //   user: user, 
          //   index: index,);
        },
      ),
    );
  }
}

class _ListItem  extends StatelessWidget {
  final Widget child;
  final User data;
  final int index;

  const _ListItem({Key key, this.child, this.data, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ReorderableDragStartListener(
      index: index,
        child: LongPressDraggable<User>(
        dragAnchor: DragAnchor.child,
        data: data,
        feedback: SizedBox(
          width: 355.0 - 16.0,
          child: child,
        ),
        child: child,
      ),
    );
  }
}

// class _ListItem extends StatelessWidget {
//   const _ListItem({
//     Key key,
//     @required this.user,
//     @required this.index,
//   }) : super(key: key);

//   final User user;
//   final int index;


//   @override
//   Widget build(BuildContext context) {

//     return Draggable(
//       // key: ValueKey(user),
//       dragAnchor: DragAnchor.pointer,
//       data: user,
//       feedback: SizedBox(
//         width: 200.0,
//         child: Material(
//           color:  Colors.transparent,
//           child: Container(
//               margin: const EdgeInsets.all(4.0),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 border: Border.all(
//                   color: Colors.grey,
//                 ),
//                 borderRadius: BorderRadius.circular(5.0)
//               ),
//               child: ListTile(
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(15.0),
//                 ),
//                 leading: ClipRRect(
//                   borderRadius: BorderRadius.circular(8.0),
//                   child: Container(
//                     color: user.color,
//                     width: 40.0,
//                     height: 40.0,
//                   ),
//                   //   child: CachedNetworkImage(
//                   //   fit: BoxFit.cover,
//                   //   width: 40.0,
//                   //   height: 40.0,
//                   //   imageUrl: user.imageUrl,
//                   //   placeholder: (context, url) => CircularProgressIndicator(),
//                   //   errorWidget: (context, url, error) => Icon(Icons.error),
//                   // ),
//                 ),
//                 title: Text(user.name),
//               ),
//             ),
//         ),
//       ),
//       child: Material(
//           color:  Colors.transparent,
//           child: Container(
//           margin: const EdgeInsets.symmetric(vertical: 4.0),
//           padding: const EdgeInsets.all(8.0),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             // border: Border.all(
//             //   color: Colors.grey,
//             // ),
//             borderRadius: BorderRadius.circular(5.0),
//             boxShadow: <BoxShadow>[
//               BoxShadow(
//                 color: Colors.grey[300],
//                 blurRadius: 3.0,
//                 offset: Offset(-1.0, 0),
//               ),
//             ],
//           ),
//           child: ListTile(
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(15.0),
//             ),
//             leading: ClipRRect(
//               borderRadius: BorderRadius.circular(8.0),
//               child: Container(
//                 color: user.color,
//                 width: 40.0,
//                 height: 40.0,
//               ),
//               //   child: CachedNetworkImage(
//               //   fit: BoxFit.cover,
//               //   width: 40.0,
//               //   height: 40.0,
//               //   imageUrl: user.imageUrl,
//               //   placeholder: (context, url) => CircularProgressIndicator(),
//               //   errorWidget: (context, url, error) => Icon(Icons.error),
//               // ),
//             ),
//             title: Text(user.name),
//             trailing: ReorderableDragStartListener(
//               index: index,
//               child: Icon(Icons.drag_handle_rounded)),
//           ),
//         ),
//       ),
//     );
//   }
// }

class CustomItem extends StatefulWidget {
  final int index;
  final User user;

  const CustomItem({
    Key key, 
    this.index, 
    this.user
  }) : super(key: key);

  @override
  _CustomItemState createState() => _CustomItemState();
}

class _CustomItemState extends State<CustomItem> {
  @override
  Widget build(BuildContext context) {
    return Material(
          color:  Colors.transparent,
          child: Container(
          margin: const EdgeInsets.symmetric(vertical: 4.0),
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            // color: widget.user.color, // Colors.white,
            // border: Border.all(
            //   color: Colors.grey,
            // ),
            borderRadius: BorderRadius.circular(5.0),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.grey[300],
                blurRadius: 3.0,
                offset: Offset(-1.0, 0),
              ),
            ],
          ),
          child: ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            // leading: Checkbox(
            //   value: widget.user.isDone, 
            //   onChanged: (newState) {
            //     setState(() {
            //       widget.user.isDone = newState;
            //     });
            //   }
            // ),
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Container(
                color: widget.user.color,
                width: 40.0,
                height: 40.0,
              ),
              //   child: CachedNetworkImage(
              //   fit: BoxFit.cover,
              //   width: 40.0,
              //   height: 40.0,
              //   imageUrl: user.imageUrl,
              //   placeholder: (context, url) => CircularProgressIndicator(),
              //   errorWidget: (context, url, error) => Icon(Icons.error),
              // ),
            ),
            title: Text(widget.user.name),
            trailing: ReorderableDragStartListener(
              index: widget.index,
              child: Icon(Icons.drag_handle_rounded)),
          ),
        ),
      );
  }
}


