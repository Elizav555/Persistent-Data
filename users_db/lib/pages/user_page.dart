import 'package:flutter/material.dart';
import 'package:users_db/pages/add_user_page.dart';

import '../db/database.dart';
import '../utils/routes.dart';

class UserArguments {
  final User user;
  final Future<bool> Function(User) updateUser;

  UserArguments(this.user, this.updateUser);
}

class UserPage extends StatefulWidget {
  const UserPage({Key? key, required this.user, required this.updateUser})
      : super(key: key);
  final User user;
  final Future<bool> Function(User) updateUser;

  @override
  State<StatefulWidget> createState() => UserPageState();
}

class UserPageState extends State<UserPage> {
  late final User _user;

  @override
  void didChangeDependencies() {
    setState(() {
      _user = widget.user;
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('${_user.firstName} ${_user.lastName}'),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(Routes.addUser,
                      arguments: AddUserArguments(
                          updateUser: widget.updateUser, user: _user));
                },
                icon: const Icon(Icons.edit))
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.network(_user.avatar),
            ),
            Text('Id : ${_user.id}'),
            Text('Age : ${_user.age}'),
            Text('Phone : ${_user.phoneNumber}'),
          ],
        ));
  }
}
