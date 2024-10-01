import '../helpers/custom_snackbar.dart';
import '../services/auth_service.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  List<User> users = [
    User(name: 'User 1', email: 'email 1', uid: 'uid 1', isOnline: true),
    User(name: 'User 2', email: 'email 2', uid: 'uid 2', isOnline: false),
    User(name: 'User 3', email: 'email 3', uid: 'uid 3', isOnline: true),
    User(name: 'User 4', email: 'email 4', uid: 'uid 4', isOnline: false),
    User(name: 'User 5', email: 'email 5', uid: 'uid 5', isOnline: true),
  ];

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    final user = authService.user;

    return Scaffold(
        appBar: AppBar(
          title: Text(user.name, style: const TextStyle(color: Colors.black87)),
          elevation: 1,
          backgroundColor: Colors.white,
          leading: const Icon(Icons.wifi, color: Colors.green),
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 10),
              child: IconButton(
                icon: const Icon(Icons.exit_to_app),
                onPressed: () {
                  // Navigate to logout page
                  Navigator.pushReplacementNamed(context, 'login');
                  AuthService().logout();
                },
              ),
            )
          ],
        ),
        body: SmartRefresher(
          controller: _refreshController,
          enablePullDown: true,
          onRefresh: () async {
            await Future.delayed(const Duration(milliseconds: 1000));
            _refreshController.refreshCompleted();
          },
          child: _listViewUses(),
        ));
  }

  ListView _listViewUses() {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) => _userListTile(users[index]),
      separatorBuilder: (context, index) => const Divider(),
      itemCount: users.length,
    );
  }

  ListTile _userListTile(User user) {
    return ListTile(
      title: Text(user.name),
      subtitle: Text(user.email),
      leading: CircleAvatar(
        child: Text(user.name.substring(0, 2)),
      ),
      trailing: Text(
        user.isOnline ? 'Online' : 'Offline',
        style: TextStyle(
            color: user.isOnline ? Colors.green : Colors.red,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
