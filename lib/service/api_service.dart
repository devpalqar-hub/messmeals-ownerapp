import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApiService {
  static const String baseUrl = "https://api.messmeals.com";
  static const storage = FlutterSecureStorage();

  /// ================= TOKEN =================
  static Future<void> saveToken(String token) async {
    await storage.write(key: "token", value: token);
  }

  static Future<String?> getToken() async {
    return await storage.read(key: "token");
  }

  static Future<Map<String, String>> _headers() async {
    final token = await getToken();

    return {
      "Content-Type": "application/json",
      if (token != null) "Authorization": "Bearer $token",
    };
  }

  /// ================= SEND LOGIN OTP =================
  static Future<bool> sendLoginOtp(String phone) async {
    final res = await http.post(
      Uri.parse("$baseUrl/auth/send-login-otp"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"phone": phone}),
    );

    final data = jsonDecode(res.body);

    if (res.statusCode == 200) {
      return true;
    } else {
      throw Exception(data["message"] ?? "OTP send failed");
    }
  }

  /// ================= VERIFY OTP =================
  static Future<bool> verifyOtp(String phone, String otp) async {
    final res = await http.post(
      Uri.parse("$baseUrl/auth/verify-login-otp"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "phone": phone,
        "otp": otp,
      }),
    );

    final data = jsonDecode(res.body);

    if (res.statusCode == 200) {
      if (data["token"] != null) {
        await saveToken(data["token"]);
      }
      return true;
    } else {
      throw Exception(data["message"] ?? "OTP verify failed");
    }
  }



  /// ================= GET OWNER MESSES =================
  static Future<List<dynamic>> getOwnerMesses() async {
    final res = await http.get(
      Uri.parse("$baseUrl/mess"),
      headers: await _headers(),
    );

    final decoded = jsonDecode(res.body);

   
    if (decoded is Map && decoded.containsKey("data")) {
      return decoded["data"];
    }

    return [];
  }

  /// ================= DASHBOARD =================
  static Future<Map<String, dynamic>> getDashboard(String messId) async {
    final res = await http.get(
      Uri.parse("$baseUrl/auth/stats?messId=$messId"),
      headers: await _headers(),
    );

    return jsonDecode(res.body);
  }
  /// ================= GET ALL MESSES =================
  static Future<List<dynamic>> getAllMesses() async {
    final res = await http.get(
      Uri.parse("$baseUrl/mess"),
      headers: await _headers(),
    );

    final data = jsonDecode(res.body);

    if (res.statusCode == 200) {
      return data["data"];
    } else {
      throw Exception(data["message"] ?? "Failed to load messes");
    }
  }
}
