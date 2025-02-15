import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:healtether_app/models/user_model.dart';

const String apiUrl = 'https://jsonplaceholder.typicode.com/users';

class UserProvider with ChangeNotifier {
  List<UserModel> _users = []; //'UserModel' objects representing the users.
  bool _isLoading = false; //indicates if data is currently being fetched.
  String?
      _errorMessage; //stores any error messages encountered during data fetching.

  List<UserModel> get users => _users; //Returns the list of users.
  bool get isLoading => _isLoading; //Returns the loading state.
  String? get errorMessage =>
      _errorMessage; //Returns the error message, if any.

  Future<void> fetchUsers() async {
    //updates the loading state and error message accordingly and notifies listeners of any changes.
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final List<dynamic> userData = json.decode(response.body);
        _users = userData.map((json) => UserModel.fromJson(json)).toList();
        _filteredUsers = List.from(
            _users); //initializes filtered users with the full list of users.
        _errorMessage = null;
      } else {
        _errorMessage = 'Failed to load users';
      }
    } catch (e) {
      _errorMessage = 'An error occurred: $e';
    }

    _isLoading = false;
    notifyListeners();
  }

  List<UserModel> _filteredUsers = []; //stores the filtered list of users.
  String _searchQuery = '';

  List<UserModel> get filteredUsers =>
      _filteredUsers; //access to filtered users
  String get searchQuery => _searchQuery;

  void searchUsers(String query) {
    _searchQuery = query; //update search query with new input
    if (query.isEmpty) {
      //if search query is empty, display all users
      _filteredUsers = _users;
    } else {
      //filters users based on search query, case doesn't matter
      _filteredUsers = _users
          .where((user) =>
              user.name.toLowerCase().contains(query.toLowerCase()) ||
              user.email.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners(); //notifies listeners of any changes
  }
}
