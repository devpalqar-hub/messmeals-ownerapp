import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApiService {
  static const String baseUrl = "https://api.messmeals.com";
  static const FlutterSecureStorage storage = FlutterSecureStorage();

  static Map<String, String> _headers({String? token}) {
    return {
      "Content-Type": "application/json",
      if (token != null) "Authorization": "Bearer $token",
    };
  }

  // ================= NORMAL LOGIN =================
  static Future<Map<String, dynamic>> login(
      String email,
      String password,
      ) async {
    final response = await http.post(
      Uri.parse("$baseUrl/auth/login"),
      headers: _headers(),
      body: jsonEncode({
        "email": email,
        "password": password,
      }),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      final token = data["accessToken"] ?? data["token"];

      if (token != null) {
        await storage.write(key: "accessToken", value: token.toString());
      }

      return data;
    } else {
      throw Exception(data["message"] ?? "Login Failed");
    }
  }

  // ================= LOGIN OTP =================
  static Future<Map<String, dynamic>> sendLoginOtp(String phone) async {
    final response = await http.post(
      Uri.parse("$baseUrl/auth/send-login-otp"),
      headers: _headers(),
      body: jsonEncode({"phone": phone}),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return data;
    } else {
      throw Exception(data["message"] ?? "Failed to send OTP");
    }
  }

  // ================= VERIFY OTP =================
  static Future<void> verifyOtp({
    required String phone,
    required String sessionId,
    required String otp,
  }) async {
    final response = await http.post(
      Uri.parse("$baseUrl/auth/verify-otp"),
      headers: _headers(),
      body: jsonEncode({
        "phone": phone,
        "sessionId": sessionId,
        "otp": otp,
      }),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      final token = data["accessToken"] ?? data["token"];

      if (token != null) {
        await storage.write(key: "accessToken", value: token.toString());
      } else {
        throw Exception("Token not received from server");
      }
    } else {
      throw Exception(data["message"] ?? "OTP Verification Failed");
    }
  }

  // ================= TOKEN =================
  static Future<String?> getToken() async {
    return await storage.read(key: "accessToken");
  }

  static Future<void> logout() async {
    await storage.delete(key: "accessToken");
  }

  // ================= AUTHORIZED GET =================
  static Future<Map<String, dynamic>> authorizedGet(
      String endpoint) async {
    final token = await getToken();

    if (token == null) {
      throw Exception("Token not found. Please login again.");
    }

    final response = await http.get(
      Uri.parse("$baseUrl$endpoint"),
      headers: _headers(token: token),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return data;
    } else if (response.statusCode == 401) {
      await logout();
      throw Exception("Session expired. Please login again.");
    } else {
      throw Exception(data["message"] ?? "Request Failed");
    }
  }

  // ================= AUTHORIZED POST =================
  static Future<Map<String, dynamic>> authorizedPost(
      String endpoint,
      Map<String, dynamic> body,
      ) async {
    final token = await getToken();

    if (token == null) {
      throw Exception("Token not found. Please login again.");
    }

    final response = await http.post(
      Uri.parse("$baseUrl$endpoint"),
      headers: _headers(token: token),
      body: jsonEncode(body),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return data;
    } else {
      throw Exception(data["message"] ?? "Request Failed");
    }
  }

  // ================= DASHBOARD =================
  static Future<Map<String, dynamic>> getDashboardStats(
      int? messId) async {
    String endpoint = "/auth/stats";

    if (messId != null) {
      endpoint += "?messId=$messId";
    }

    return await authorizedGet(endpoint);
  }

  // ================= GET ALL MESSES =================
  static Future<List<dynamic>> getAllMesses() async {
    final response = await authorizedGet("/mess");

    final data = response["data"];

    if (data is List) {
      return data;
    } else {
      return [];
    }
  }
}
