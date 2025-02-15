import 'package:flutter/material.dart';
import 'package:healtether_app/services/api_service.dart';
import 'package:healtether_app/models/user_model.dart';

class UserProvider extends ChangeNotifier {
  //manages the state of user data and notifies listeners of changes.
  final ApiService _apiService =
      ApiService(); //instance of 'ApiService' to fetch user data from an API.

  List<UserModel> _users =
      []; //A list of 'UserModel' objects representing the users.
  bool _isLoading = false; //indicates if data is currently being fetched.
  String?
      _errorMessage; // stores any error messages encountered during data fetching.

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
      _users = await _apiService.fetchUsers();
    } catch (e) {
      _errorMessage = e.toString();
    }
    _isLoading = false;
    notifyListeners();
  }
}
