import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medb/core/colors/colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,

    primaryColor: AppColors.primaryBlue,
    scaffoldBackgroundColor: AppColors.background,

    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.surface,
      elevation: 0,
      iconTheme: const IconThemeData(color: Colors.black87),
      titleTextStyle: GoogleFonts.poppins(
        color: Colors.black87,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
        textStyle: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primaryBlue,
        textStyle: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        side: const BorderSide(color: Color(0xFF6F64E7)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.surface,
      hintStyle: GoogleFonts.lato(
        color: Colors.black45,
        fontSize: 14,
      ),
      labelStyle: GoogleFonts.lato(
        color: Colors.black54,
        fontSize: 16,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.primaryBlue),
      ),
    ),

    textTheme: TextTheme(
      
      headlineLarge: GoogleFonts.poppins(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      headlineMedium: GoogleFonts.poppins(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
      headlineSmall: GoogleFonts.poppins(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
      ),
      
      
      titleLarge: GoogleFonts.poppins(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      titleMedium: GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      titleSmall: GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Colors.black87,
      ),

    
      bodyLarge: GoogleFonts.lato(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: AppColors.primaryBlue,
      ),
      bodyMedium: GoogleFonts.lato(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: Colors.black87,
      ),
      bodySmall: GoogleFonts.lato(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: Colors.black54,
      ),

    
      labelLarge: GoogleFonts.lato(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Colors.black87,
      ),
      labelMedium: GoogleFonts.lato(
        fontSize: 13,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      labelSmall: GoogleFonts.lato(
        fontSize: 13,
        fontWeight: FontWeight.w500,
        color: const Color.fromARGB(255, 58, 56, 56),
      ),
    ),

  
    fontFamily: GoogleFonts.lato().fontFamily, 
  );
}