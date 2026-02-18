import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'service/api_service.dart';
import 'screens/login_screen.dart';
import 'screens/otp_page.dart';
import 'screens/main_layout.dart';

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
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: token != null ? "/main" : "/login",
      getPages: [
        GetPage(
          name: "/login",
          page: () => const LoginScreen(),
        ),
        GetPage(
          name: "/otp",
          page: () => const OtpPage(),
        ),
        GetPage(
          name: "/main",
          page: () => const MainLayout(),
        ),
      ],
    );
  }
}
