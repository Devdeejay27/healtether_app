class UserModel {
  final int id; //unique id for user
  final String name; // user's full name
  final String email; // user's email address

  /// Represents a user in the application.
  UserModel({
    required this.id,
    required this.name,
    required this.email,
  });

  //new instance of UserModel from a JSON object
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
    );
  }
}
