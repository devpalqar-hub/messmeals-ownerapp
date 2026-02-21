import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApiService {
  static const String baseUrl = "https://api.messmeals.com";
  static const FlutterSecureStorage storage = FlutterSecureStorage();

  /// ================= HEADERS =================
  static Map<String, String> _headers({String? token}) {
    return {
      "Content-Type": "application/json",
      if (token != null) "Authorization": "Bearer $token",
    };
  }

  /// ================= TOKEN =================
  static Future<String?> getToken() async {
    return await storage.read(key: "accessToken");
  }

  static Future<void> saveToken(String token) async {
    await storage.write(key: "accessToken", value: token);
  }

  static Future<void> logout() async {
    await storage.delete(key: "accessToken");
  }

  /// ================= COMMON REQUESTS =================
  static Future<Map<String, dynamic>> authorizedGet(String endpoint) async {
    final token = await getToken();

    final response = await http.get(
      Uri.parse("$baseUrl$endpoint"),
      headers: _headers(token: token),
    );

    return _handleResponse(response);
  }

  static Future<Map<String, dynamic>> authorizedPost(
      String endpoint, Map<String, dynamic> body) async {
    final token = await getToken();

    final response = await http.post(
      Uri.parse("$baseUrl$endpoint"),
      headers: _headers(token: token),
      body: jsonEncode(body),
    );

    return _handleResponse(response);
  }

  static Future<Map<String, dynamic>> authorizedPatch(
      String endpoint, Map<String, dynamic> body) async {
    final token = await getToken();

    final response = await http.patch(
      Uri.parse("$baseUrl$endpoint"),
      headers: _headers(token: token),
      body: jsonEncode(body),
    );

    return _handleResponse(response);
  }

  static Future<void> authorizedDelete(String endpoint) async {
    final token = await getToken();

    final response = await http.delete(
      Uri.parse("$baseUrl$endpoint"),
      headers: _headers(token: token),
    );

    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception("Delete failed");
    }
  }

  static Map<String, dynamic> _handleResponse(http.Response response) {
    final data = jsonDecode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return data;
    } else if (response.statusCode == 401) {
      logout();
      throw Exception("Session expired");
    } else {
      throw Exception(data["message"] ?? "Request Failed");
    }
  }

  /// ================= AUTH =================
  static Future<Map<String, dynamic>> login(String phone) async {
    return await authorizedPost("/auth/login", {"phone": phone});
  }

  static Future<Map<String, dynamic>> verifyOtp(
      String phone, String otp) async {
    final res =
    await authorizedPost("/auth/verify-otp", {"phone": phone, "otp": otp});

    if (res["token"] != null) {
      await saveToken(res["token"]);
    }

    return res;
  }

  /// ================= DASHBOARD =================
  static Future<Map<String, dynamic>> getDashboardStats(String s) async {
    return await authorizedGet("/dashboard");
  }

  /// ================= MESSES =================
  static Future<List<dynamic>> getAllMesses() async {
    final response = await authorizedGet("/mess");
    return response["data"] ?? [];
  }

  /// ================= PLANS =================
  static Future<Map<String, dynamic>> getPlans(String messId) async {
    return await authorizedGet("/plans?page=1&limit=10&messId=$messId");
  }

  /// ================= CUSTOMERS =================
  static Future<Map<String, dynamic>> getCustomers(String messId) async {
    return await authorizedGet("/customer?page=1&limit=10&messId=$messId");
  }

  static Future<Map<String, dynamic>> addCustomer(
      Map<String, dynamic> body) async {
    return await authorizedPost("/customer", body);
  }

  static Future<Map<String, dynamic>> updateCustomer(
      String id, Map<String, dynamic> body) async {
    return await authorizedPatch("/customer/$id", body);
  }

  static Future<void> deleteCustomer(String id) async {
    await authorizedDelete("/customer/$id");
  }

  /// ================= DELIVERY AGENTS =================
  static Future<Map<String, dynamic>> getPartners(String messId) async {
    return await authorizedGet(
        "/delivery-agent?page=1&limit=10&messId=$messId");
  }

  static Future<Map<String, dynamic>> addPartner(
      Map<String, dynamic> body) async {
    return await authorizedPost("/delivery-agent", body);
  }

  static Future<dynamic> sendLoginOtp(String phone) async {}
}