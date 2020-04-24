import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(nullable: false)
class SignUpModel {
  String name;
  String email;
  String username;
  String password;

  SignUpModel({this.name, this.email, this.username, this.password});

  Map<String, dynamic> toJson() => {
        'name': name.toString(),
        'email': email.toString(),
        'username': username.toString(),
        'password': password.toString()
      };
}
