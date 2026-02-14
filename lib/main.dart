import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'screens/main_layout.dart';


String baseUrl = "https://api.messmeals.com";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme:ThemeData(
        fontFamily: 'Inter',
        textTheme: TextTheme(
          displayLarge: TextStyle(fontFamily: 'Inter', fontSize: 32, fontWeight: FontWeight.bold),
          displayMedium: TextStyle(fontFamily: 'Inter', fontSize: 28, fontWeight: FontWeight.bold),
          displaySmall: TextStyle(fontFamily: 'Inter', fontSize: 24, fontWeight: FontWeight.bold),
          headlineLarge: TextStyle(fontFamily: 'Inter', fontSize: 22, fontWeight: FontWeight.w600),
          headlineMedium: TextStyle(fontFamily: 'Inter', fontSize: 20, fontWeight: FontWeight.w600),
          headlineSmall: TextStyle(fontFamily: 'Inter', fontSize: 18, fontWeight: FontWeight.w600),
          titleLarge: TextStyle(fontFamily: 'Inter', fontSize: 16, fontWeight: FontWeight.w600),
          titleMedium: TextStyle(fontFamily: 'Inter', fontSize: 14, fontWeight: FontWeight.w500),
          titleSmall: TextStyle(fontFamily: 'Inter', fontSize: 12, fontWeight: FontWeight.w500),
          bodyLarge: TextStyle(fontFamily: 'Inter', fontSize: 16, fontWeight: FontWeight.normal),
          bodyMedium: TextStyle(fontFamily: 'Inter', fontSize: 14, fontWeight: FontWeight.normal),
          bodySmall: TextStyle(fontFamily: 'Inter', fontSize: 12, fontWeight: FontWeight.normal),
          labelLarge: TextStyle(fontFamily: 'Inter', fontSize: 14, fontWeight: FontWeight.w600),
          labelSmall: TextStyle(fontFamily: 'Inter', fontSize: 11, fontWeight: FontWeight.w500),
        )
      ) ,
      home: MainLayout(),
    );
  }
}