class SignInModel {
  String username;
  String password;

  SignInModel({this.username, this.password});

  Map<String, dynamic> toJson() =>
      {'username': username.toString(), 'password': password.toString()};
}
