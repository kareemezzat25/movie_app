import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/models/moviesapiservice.dart';

class SearchTab extends StatefulWidget {
  const SearchTab({super.key});

  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  List<dynamic> movies = [];
  bool isLoading = false;

  void searchMovies(String query) async {
    if (query.isEmpty) {
      setState(() {
        movies = [];
      });
      return;
    }

    setState(() {
      isLoading = true;
    });

    final results = await MovieApi.searchMovies(query);

    setState(() {
      movies = results;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              SizedBox(height: 10.h),
              TextField(
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(color: Colors.white),
                onChanged: (value) => searchMovies(value),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFF282A28),
                  hintText: "Search",
                  hintStyle: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(color: Colors.white),
                  prefixIcon: const ImageIcon(
                      AssetImage("assets/images/searchIcon.png"),
                      color: Colors.white),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.r)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.r)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.r)),
                ),
              ),
              SizedBox(height: 10.h),
              Expanded(
                child: isLoading
                    ? const Center(
                        child: CircularProgressIndicator(color: Colors.white))
                    : movies.isEmpty
                        ? Center(
                            child: Image.asset("assets/images/Empty.png",
                                fit: BoxFit.fill, width: 124.w, height: 124.h))
                        : GridView.builder(
                            padding: const EdgeInsets.all(8),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.7,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                            ),
                            itemCount: movies.length,
                            itemBuilder: (context, index) {
                              final movie = movies[index];
                              final posterPath = movie["poster_path"];

                              final posterUrl = posterPath != null
                                  ? "https://image.tmdb.org/t/p/w500$posterPath"
                                  : "assets/images/placeholder.jpg";
                              final rating =
                                  movie["vote_average"]?.toString() ?? "N/A";

                              return ClipRRect(
                                borderRadius: BorderRadius.circular(16.r),
                                child: Stack(
                                  children: [
                                    if (posterPath == null) ...[
                                      Image.asset(posterUrl, fit: BoxFit.cover)
                                    ] else ...[
                                      Image.network(posterUrl,
                                          width: 190.w,
                                          height: 278.h,
                                          fit: BoxFit.cover),
                                    ],
                                    Positioned(
                                      top: 8,
                                      left: 8,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 12),
                                        decoration: BoxDecoration(
                                          color: Color(0xFF121312),
                                          borderRadius:
                                              BorderRadius.circular(10.r),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(rating,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleSmall!
                                                    .copyWith(
                                                        color: Colors.white)),
                                            SizedBox(width: 4.w),
                                            Icon(Icons.star,
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                size: 14),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
