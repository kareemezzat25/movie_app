import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:introduction_screen/introduction_screen.dart';

import 'package:flutter/material.dart';
import 'package:movies_app/main.dart';
import 'package:movies_app/views/login.dart';

class OnBoarding extends StatefulWidget {
  static const String routeName = "OnBoarding";
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoarding> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> onboardingData = [
    {
      "image": "assets/images/onBoarding1.png",
      "title": "Find Your Next Favorite Movie Here",
      "description":
          "Get access to a huge library of movies to suit all tastes."
    },
    {
      "image": "assets/images/onBoarding2.png",
      "title": "Discover Movies",
      "description":
          "Explore a vast collection of movies in all qualities and genres."
    },
    {
      "image": "assets/images/onBoarding3.png",
      "title": "Explore All Genres",
      "description":
          "Discover movies from every genre in all available qualities."
    },
    {
      "image": "assets/images/onBoarding4.png",
      "title": "Create Watchlists",
      "description":
          "Save movies to your watchlist to keep track of what you want to watch."
    },
    {
      "image": "assets/images/onBoarding5.png",
      "title": "Create Watchlists",
      "description":
          "Save movies to your watchlist to keep track of what you want to watch."
    },
    {
      "image": "assets/images/onBoarding6.png",
      "title": "Create Watchlists",
      "description":
          "Save movies to your watchlist to keep track of what you want to watch."
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: onboardingData.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              return Image.asset(
                onboardingData[index]["image"]!,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              );
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.8),
                borderRadius: BorderRadius.vertical(top: Radius.circular(40.r)),
              ),
              height: 230,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(onboardingData[_currentPage]["title"]!,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleLarge),
                    SizedBox(height: 16.h),
                    Text(
                      onboardingData[_currentPage]["description"]!,
                      textAlign: TextAlign.center,
                      style: _currentPage == 0
                          ? Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(color: Colors.white.withOpacity(0.6))
                          : Theme.of(context).textTheme.titleMedium,
                    ),
                    SizedBox(height: 24.h),
                    Column(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            if (_currentPage == onboardingData.length - 1) {
                              Navigator.pushNamed(context, LoginView.routeName);
                            } else {
                              _pageController.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            minimumSize: Size(398.w, 55.h),
                            backgroundColor: Theme.of(context).primaryColor,
                          ),
                          child: Text(
                            _currentPage == onboardingData.length - 1
                                ? "Finish"
                                : _currentPage == 0
                                    ? "Explore Now"
                                    : "Next",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        _currentPage > 1
                            ? ElevatedButton(
                                onPressed: () {
                                  _pageController.previousPage(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(vertical: 16),
                                  minimumSize: Size(398.w, 55.h),
                                  backgroundColor: Colors.transparent,
                                  side: BorderSide(
                                      color: Theme.of(context).primaryColor),
                                ),
                                child: Text(
                                  "Back",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                          color: Theme.of(context).primaryColor,
                                          fontWeight: FontWeight.w600),
                                ),
                              )
                            : const SizedBox(width: 80),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
