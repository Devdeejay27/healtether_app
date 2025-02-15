import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:healtether_app/provider/user_provider.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<UserProvider>().fetchUsers());
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('User List')),
      body: Column(
        children: [
          Padding(
            padding: padding.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onChanged: (query) => userProvider.searchUsers(query),
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () => userProvider.fetchUsers(),
              child: Center(
                child: userProvider.isLoading
                    ? const CircularProgressIndicator()
                    : userProvider.errorMessage != null
                        ? Text(userProvider.errorMessage!)
                        : ListView.builder(
                            itemCount: userProvider.users.length,
                            itemBuilder: (context, index) {
                              final user = userProvider.users[index];
                              return ListTile(
                                leading: CircleAvatar(
                                  child: Text(user.name[0]),
                                ),
                                title: Text(user.name),
                                subtitle: Text(
                                  user.email,
                                ),
                              );
                            },
                          ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
