// Importing necessary packages
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:healtether_app/models/user_model.dart';

class ApiService {
  static const String apiUrl = 'https://jsonplaceholder.typicode.com/users';

  // 'fetchUsers' method is an asynchronous function that fetches a list of users from the API.
  Future<List<UserModel>> fetchUsers() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        //http request is successful
        List<dynamic> data = json.decode(response.body);
        return data.map((json) => UserModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load users'); // http request fails
      }
    } catch (e) {
      throw Exception(
          'Error: $e'); // catches any other error that occurs during the request
    }
  }
}
