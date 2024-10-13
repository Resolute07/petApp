
    import 'package:flutter/material.dart';
import 'package:petapp/core/theme/colors.dart';

final ThemeData lightTheme = ThemeData(
       textTheme: const TextTheme(
                headlineMedium: TextStyle(
                    color: black, fontSize: 24, fontWeight: FontWeight.w700),
                labelMedium: TextStyle(
                    color: black, fontSize: 20, fontWeight: FontWeight.w600),
                labelSmall: TextStyle(
                    color: black, fontSize: 16, fontWeight: FontWeight.w500),
                bodyMedium: TextStyle(
                  color: black,
                ),
                bodySmall: TextStyle(
                  color: black,
                ),
                titleSmall: TextStyle( color: black, fontSize: 22, fontWeight: FontWeight.w600),
                displaySmall: TextStyle( color: blue, fontSize: 18, fontWeight: FontWeight.w400)
                
                
                
                ),
        
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
            useMaterial3: true,
  );



final ThemeData darkTheme = ThemeData(
  textTheme: const TextTheme(
    headlineMedium: TextStyle(
        color: Colors.white, fontSize: 24, fontWeight: FontWeight.w700),
    labelMedium: TextStyle(
        color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
    labelSmall: TextStyle(
        color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
    bodyMedium: TextStyle(
      color: Colors.white70,
    ),
    bodySmall: TextStyle(
      color: Colors.white70,
    ),
    titleSmall: TextStyle(
        color: Colors.white, fontSize: 22, fontWeight: FontWeight.w600),
    displaySmall: TextStyle(
        color: Colors.blueAccent, fontSize: 18, fontWeight: FontWeight.w400),
  ),
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.blue,
    brightness: Brightness.dark, 
  ),
  useMaterial3: true,
);
