import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/models/moviesapiservice.dart';
import 'package:movies_app/views/seemoreview.dart';

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  List popularMovies = [];
  List actionMovies = [];

  @override
  void initState() {
    super.initState();
    fetchMovies();
  }

  Future<void> fetchMovies() async {
    final popular = await MovieApi.fetchPopularMovies();
    final action = await MovieApi.searchMovies("action");
    setState(() {
      popularMovies = popular;
      actionMovies = action.take(5).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (popularMovies.isNotEmpty)
                CarouselSlider(
                  options: CarouselOptions(
                    height: 350.h,
                    viewportFraction: 0.5,
                    enlargeFactor: 0.3,
                    enlargeCenterPage: true,
                    scrollDirection: Axis.horizontal,
                    autoPlay: true,
                  ),
                  items: popularMovies.map((movie) {
                    final posterPath = movie['poster_path'];
                    final posterUrl = posterPath != null
                        ? 'https://image.tmdb.org/t/p/w500$posterPath'
                        : "assets/images/placeholder.jpg";
                    final rating = movie["vote_average"]?.toString() ?? "N/A";

                    return ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Stack(
                        children: [
                          posterPath == null
                              ? Image.asset(posterUrl,
                                  height: double.infinity,
                                  fit: BoxFit.fill,
                                  width: double.infinity)
                              : Image.network(posterUrl,
                                  height: double.infinity,
                                  fit: BoxFit.fill,
                                  width: double.infinity),
                          Positioned(
                            top: 8,
                            left: 8,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.7),
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    rating,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(color: Colors.white),
                                  ),
                                  SizedBox(width: 4.w),
                                  Icon(Icons.star,
                                      color: Theme.of(context).primaryColor,
                                      size: 14),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Action',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(fontWeight: FontWeight.w400)),
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SeeMoreView()),
                    ),
                    child: Row(
                      children: [
                        Text(
                          "See More",
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        Icon(
                          Icons.arrow_forward,
                          color: Theme.of(context).primaryColor,
                        )
                      ],
                    ),
                  ),
                ],
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: actionMovies.map((movie) {
                    return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: movie['poster_path'] != null
                            ? Image.network(
                                'https://image.tmdb.org/t/p/w200${movie['poster_path']}',
                                fit: BoxFit.cover,
                              )
                            : Image.asset(
                                "assets/images/placeholder.jpg",
                                fit: BoxFit.cover,
                              ));
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
