import '../services/auth_service.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../services/chat_service.dart';
import '../services/socket_service.dart';
import '../services/users_servide.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  final usersService = UsersService();

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  List<User> users = [];

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    final socketService = Provider.of<SocketService>(context);
    final user = authService.user;

    return Scaffold(
        appBar: AppBar(
          title: Text(user.name, style: const TextStyle(color: Colors.black87)),
          elevation: 1,
          backgroundColor: Colors.white,
          leading: Icon(
              socketService.serverStatus == ServerStatus.online
                  ? Icons.wifi
                  : Icons.wifi_off,
              color: socketService.serverStatus == ServerStatus.online
                  ? Colors.green
                  : Colors.red),
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 10),
              child: IconButton(
                icon: const Icon(Icons.exit_to_app),
                onPressed: () {
                  socketService.disconnect();
                  Navigator.pushReplacementNamed(context, 'login');
                  authService.logout();
                },
              ),
            )
          ],
        ),
        body: SmartRefresher(
          controller: _refreshController,
          enablePullDown: true,
          onRefresh: _loadUsers,
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
      onTap: () {
        final chatService = Provider.of<ChatService>(context, listen: false);
        chatService.userTo = user;
        Navigator.pushNamed(context, 'chat');
      },
    );
  }

  _loadUsers() async {
    final res = await usersService.getUsers();
    _refreshController.refreshCompleted();

    users = res;
    setState(() {});
  }
}
