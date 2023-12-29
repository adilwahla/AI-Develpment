class User {
  final String token;
  final String id;
  final String name;
  final String email;
  final String password; // Consider not exposing this or storing it securely
  // final int v;

  User({
    required this.token,
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    // required this.v,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      token: json['token'],
      id: json['_id'],
      name: json['name'],
      email: json['email'],
      password: json[
          'password'], // Ensure you handle this securely, don't expose or store it unnecessarily
      // v: json['__v'],
    );
  }
}


// import 'dart:convert';

// class User {
//   final String? id;
//   final String? name;
//   final String? email;
//   final String? token;
//   final String? password;
//   User({
//     required this.id,
//     required this.name,
//     required this.email,
//     required this.token,
//     required this.password,
//   });

//   Map<String, dynamic> toMap() {
//     return {
//       'name': name,
//       'email': email,
//       'token': token,
//       'password': password,
//     };
//   }

//   factory User.fromMap(Map<String, dynamic> map) {
//     return User(
//       id: map['_id'],
//       name: map['name'],
//       email: map['email'],
//       token: map['token'],
//       password: map['password'],
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory User.fromJson(String source) => User.fromMap(json.decode(source));
// }
