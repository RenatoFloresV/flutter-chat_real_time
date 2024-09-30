import '../models/user.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class UsersPages extends StatefulWidget {
  const UsersPages({super.key});

  @override
  State<UsersPages> createState() => _UsersPagesState();
}

class _UsersPagesState extends State<UsersPages> {
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
    return Scaffold(
        appBar: AppBar(
          title: const Text('User name'),
          elevation: 1,
          backgroundColor: Colors.white,
          leading: const Icon(Icons.wifi, color: Colors.green),
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 10),
              child: const Icon(Icons.exit_to_app),
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
