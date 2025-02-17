import 'dart:convert';
import 'package:http/http.dart' as http;

class UserService {
  final String token;
  static const String baseUrl = "https://route-movie-apis.vercel.app";

  UserService({required this.token});

  Future<Map<String, dynamic>> fetchUserProfile() async {
    final response = await http.get(
      Uri.parse('$baseUrl/profile'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load profile');
    }
  }

  Future<void> deleteAccount() async {
    final response = await http.delete(
      Uri.parse('$baseUrl/profile'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete profile');
    }
  }
}
