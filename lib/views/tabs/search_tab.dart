import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchTab extends StatelessWidget {
  const SearchTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              TextField(
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(color: Colors.white),
                decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFF282A28),
                    hintText: "Search",
                    hintStyle: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(color: Colors.white),
                    prefixIcon: ImageIcon(
                      AssetImage("assets/images/searchIcon.png"),
                      color: Colors.white,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.r)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.r)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.r))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
