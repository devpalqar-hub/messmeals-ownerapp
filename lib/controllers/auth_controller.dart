import 'package:get/get.dart';
import '../service/api_service.dart' show ApiService; // ✅ Keep ONLY one correct import

class AuthController extends GetxController {
  var isLoading = false.obs;

  Future<void> login(String email, String password) async {
    try {
      isLoading.value = true;
      final data = await ApiService.login(email, password);

      print("Login Response: $data");

      Get.snackbar(
        "Success",
        "Login successful",
        snackPosition: SnackPosition.BOTTOM,
      );

      Get.offAllNamed("/dashboard");

    } catch (e) {
      print("Login Error: $e");

      Get.snackbar(
        "Error",
        e.toString().replaceAll("Exception: ", ""),
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
