import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:healtether_app/provider/user_provider.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

// Initializes the state of the widget and fetches the user list.
class _UserListScreenState extends State<UserListScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context
        .read<UserProvider>()
        .fetchUsers()); // fetches users, ensuring API request is triggered as soon as screen loads without blocking the UI.
  }

  // Builds the widget tree for the user list screen.
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('User List'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search users...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              // Updates the user list based on the search query.
              onChanged: (query) => userProvider.searchUsers(query),
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              // Refreshes the user list when pulled down.
              onRefresh: () => userProvider.fetchUsers(),
              child: Center(
                child: userProvider.isLoading
                    ? const CircularProgressIndicator()
                    : userProvider.errorMessage != null
                        ? Text(userProvider.errorMessage!)
                        : ListView.builder(
                            itemCount: userProvider.filteredUsers.length,
                            itemBuilder: (context, index) {
                              final user = userProvider.filteredUsers[index];
                              return ListTile(
                                leading: CircleAvatar(
                                  child: Text(user.name[
                                      0]), //first letter of the user's name.
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
