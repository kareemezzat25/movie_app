import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movies_app/models/cache.dart';
import 'package:movies_app/models/usermodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String baseUrl = "https://route-movie-apis.vercel.app/auth";

  static Future<AuthModel> login(String email, String password) async {
    final Uri url = Uri.parse("$baseUrl/login");
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "password": password}),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final String token = data['data'];
      Cache.setToken(token);
      final authModel = AuthModel(
        message: data['message'],
        token: token,
      );
      return authModel;
    } else {
      throw Exception("Failed to login: ${response.reasonPhrase}");
    }
  }

  static Future<Map<String, dynamic>> signUp({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    required String phone,
    required int avatarId,
  }) async {
    final Uri url = Uri.parse("$baseUrl/register");
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "name": name,
        "email": email,
        "password": password,
        "confirmPassword": confirmPassword,
        "phone": phone,
        "avaterId": avatarId,
      }),
    );

    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to sign up: ${response.reasonPhrase}");
    }
  }

  Future<String?> resetPassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    String? token = Cache.getToken();

    if (token == null) return "User not authenticated";

    final response = await http.patch(
      Uri.parse('$baseUrl/reset-password'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'oldPassword': oldPassword,
        'newPassword': newPassword,
      }),
    );

    final Map<String, dynamic> data = jsonDecode(response.body);

    if (response.statusCode == 201) {
      return data['message']?.toString();
    } else {
      return data['message']?.toString();
    }
  }
}
