import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'screens/login_screen.dart';
import 'screens/otp_page.dart';
import 'screens/main_layout.dart';
import 'service/api_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final token = await ApiService.getToken();

  runApp(MyApp(token: token));
}

class MyApp extends StatelessWidget {
  final String? token;

  const MyApp({super.key, this.token});

  @override
  Widget build(BuildContext context) {
    bool isLoggedIn = token != null && token!.isNotEmpty;

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,

      /// ⭐ START PAGE
      initialRoute: isLoggedIn ? "/main" : "/login",

      /// ⭐ ROUTES
      getPages: [
        GetPage(
          name: "/login",
          page: () => LoginScreen(),
        ),
        GetPage(
          name: "/otp",
          page: () => OtpScreen(),   // ⭐ must match class name
        ),
        GetPage(
          name: "/main",
          page: () => MainLayout(),
        ),
      ],
    );
  }
}