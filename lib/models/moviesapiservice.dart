import 'dart:convert';
import 'package:http/http.dart' as http;

class MovieApi {
  static const String bearerToken =
      "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIzN2ZiODM1Y2JkMWRiZGNkYmM4Njk4MzdkZjkzNzIzMiIsIm5iZiI6MTczOTc2NTI3OS4zNzQsInN1YiI6IjY3YjJiNjFmNDFlYTYxMDQ2MjZkYzU5OSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.lQByfy8NzFjEmyFU-vgELikUFzWa0mBZxb85KNcFjEA"; // Replace with your TMDB API Key
  static const String baseUrl = "https://api.themoviedb.org/3/search/movie";

  static Future<List<dynamic>> searchMovies(String query) async {
    if (query.isEmpty) return [];

    final url = Uri.parse(
        "$baseUrl?query=$query&include_adult=false&language=en-US&page=1&api_key=$bearerToken");

    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $bearerToken',
        'accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data["results"] ?? [];
    } else {
      return [];
    }
  }
}
