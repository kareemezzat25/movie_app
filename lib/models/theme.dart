import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeLight {
  static const Color primaryColorlight = Color(0xFFF6BD00);
  static const Color secondaryColor = Color(0xFF121312);
  static ThemeData lightTheme = ThemeData(
      primaryColor: primaryColorlight,
      scaffoldBackgroundColor: secondaryColor,
      appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: primaryColorlight),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent),
      textTheme: TextTheme(
          titleLarge: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 24.sp,
              fontWeight: FontWeight.w700),
          titleMedium: GoogleFonts.inter(
              fontSize: 20.sp,
              fontWeight: FontWeight.w400,
              color: Colors.white),
          titleSmall: GoogleFonts.roboto(
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
              color: primaryColorlight)),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: secondaryColor,
          unselectedItemColor: Colors.white,
          selectedItemColor: primaryColorlight,
          type: BottomNavigationBarType.fixed));
}
