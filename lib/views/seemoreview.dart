import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/models/moviesapiservice.dart';

class SeeMoreView extends StatefulWidget {
  static const String routeName = "SeeMore";
  @override
  _SeeMoreViewState createState() => _SeeMoreViewState();
}

class _SeeMoreViewState extends State<SeeMoreView> {
  List actionMovies = [];

  @override
  void initState() {
    super.initState();
    fetchAllActionMovies();
  }

  Future<void> fetchAllActionMovies() async {
    final movies = await MovieApi.searchMovies("action");
    setState(() {
      actionMovies = movies;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        'Action Movies',
        style: Theme.of(context).textTheme.titleSmall,
      )),
      body: GridView.builder(
        padding: const EdgeInsets.all(8),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: actionMovies.length,
        itemBuilder: (context, index) {
          final movie = actionMovies[index];
          final posterPath = movie["poster_path"];

          final posterUrl = posterPath != null
              ? "https://image.tmdb.org/t/p/w500$posterPath"
              : "assets/images/placeholder.jpg";
          final rating = movie["vote_average"]?.toString() ?? "N/A";

          return ClipRRect(
            borderRadius: BorderRadius.circular(16.r),
            child: Stack(
              children: [
                if (posterPath == null) ...[
                  Image.asset(posterUrl, fit: BoxFit.cover)
                ] else ...[
                  Image.network(posterUrl,
                      width: 190.w, height: 278.h, fit: BoxFit.cover),
                ],
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                    decoration: BoxDecoration(
                      color: Color(0xFF121312),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(rating,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(color: Colors.white)),
                        SizedBox(width: 4.w),
                        Icon(Icons.star,
                            color: Theme.of(context).primaryColor, size: 14),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
