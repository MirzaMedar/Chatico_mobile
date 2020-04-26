import 'dart:convert';
import 'dart:typed_data';
import 'package:chatico/models/sign_in.dart';
import 'package:chatico/models/upload_image.dart';
import 'package:http/http.dart' as http;
import 'package:chatico/models/sign_up.dart';

String apiUrl = 'https://9357cc1e.ngrok.io';

class ApiService {
  static Future<dynamic> signUp(SignUpModel model) async {
    var response = await http.post(
      '$apiUrl/auth/register',
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
        model.toJson(),
      ),
    );

    if (response.statusCode == 200) {
      var decoded = jsonDecode(response.body);
      return Future.value(decoded);
    }

    throw Exception('There was an error while registering.');
  }

  static Future<dynamic> signIn(SignInModel model) async {
    var response = await http.post(
      '$apiUrl/auth/login',
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
        model.toJson(),
      ),
    );

    if (response.statusCode == 200) {
      var decoded = jsonDecode(response.body);
      return Future.value(decoded);
    }

    throw Exception('There was an error while registering.');
  }

  static Future<dynamic> verifyToken(String token) async {
    var response = await http.get(
      '$apiUrl/auth/verifyToken',
      headers: {
        'Content-Type': 'application/json',
        'token': token,
      },
    );

    if (response.statusCode == 200) {
      return Future.value(true);
    }

    return Future.value(false);
  }

  static String getApiUrl() {
    return apiUrl;
  }

  static Future<dynamic> getRecentChats(String userId, String token) async {
    var response = await http.get(
      '$apiUrl/chat/getRecentChats/$userId',
      headers: {
        'Content-Type': 'application/json',
        'token': token,
      },
    );

    if (response.statusCode == 200) {
      var decoded = jsonDecode(response.body);
      return Future.value(decoded);
    }

    return Future.value([]);
  }

  static Future<dynamic> getUsers(String token) async {
    var response = await http.get(
      '$apiUrl/chat/getUsers',
      headers: {
        'Content-Type': 'application/json',
        'token': token,
      },
    );

    if (response.statusCode == 200) {
      var decoded = jsonDecode(response.body);
      return Future.value(decoded);
    }

    return Future.value([]);
  }

  static Future<dynamic> getOnlineUsers(String token) async {
    var response = await http.get(
      '$apiUrl/chat/getOnlineUsers',
      headers: {
        'Content-Type': 'application/json',
        'token': token,
      },
    );

    if (response.statusCode == 200) {
      var decoded = jsonDecode(response.body);
      return Future.value(decoded);
    }

    return Future.value([]);
  }

  static Future<dynamic> getChatMessages(String userId, String token) async {
    var response = await http.get(
      '$apiUrl/chat/getChatMessages/$userId',
      headers: {
        'Content-Type': 'application/json',
        'token': token,
      },
    );

    if (response.statusCode == 200) {
      var decoded = jsonDecode(response.body);
      return Future.value(decoded);
    }

    return Future.value([]);
  }

  static Future<dynamic> uploadImage(Uint8List image, String token) async {
    var model = UploadImageModel(base64Image: base64Encode(image));
    var response = await http.post(
      '$apiUrl/users/uploadImage',
      headers: {
        'Content-Type': 'application/json',
        'token': token,
      },
      body: jsonEncode(model.toJson()),
    );

    if (response.statusCode == 200) {
      var decoded = jsonDecode(response.body);
      return Future.value(decoded);
    }

    throw Exception('There was an error while trying to upload photo.');
  }

  static Future<dynamic> getUserById(String token) async {
    var response = await http.get(
      '$apiUrl/users/getUserById',
      headers: {
        'Content-Type': 'application/json',
        'token': token,
      },
    );

    if (response.statusCode == 200) {
      var decoded = jsonDecode(response.body);
      return Future.value(decoded);
    }

    return Future.value([]);
  }
}
