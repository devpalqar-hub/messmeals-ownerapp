import 'package:get/get.dart';
import '../service/api_service.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;
  var phoneNumber = "".obs;

  /// ================= SEND LOGIN OTP =================
  Future<void> sendLoginOtp(String phone) async {
    try {
      isLoading.value = true;

      final data = await ApiService.sendLoginOtp(phone);

      phoneNumber.value = phone;

      print("OTP Sent Response: $data");

      Get.snackbar(
        "Success",
        "OTP Sent Successfully",
        snackPosition: SnackPosition.BOTTOM,
      );

      /// Navigate to OTP page
      Get.toNamed("/otp", arguments: phone);

    } catch (e) {
      print("OTP Error: $e");

      Get.snackbar(
        "Error",
        e.toString().replaceAll("Exception: ", ""),
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// ================= VERIFY OTP =================
  Future<void> verifyOtp(String otp) async {
    try {
      isLoading.value = true;

      final res = await ApiService.verifyOtp(phoneNumber.value, otp);

      print("Verify OTP Response: $res");

      Get.snackbar(
        "Success",
        "Login Successful",
        snackPosition: SnackPosition.BOTTOM,
      );

      /// Navigate to dashboard
      Get.offAllNamed("/dashboard");

    } catch (e) {
      print("Verify OTP Error: $e");

      Get.snackbar(
        "Error",
        e.toString().replaceAll("Exception: ", ""),
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// ================= LOGOUT =================
  Future<void> logout() async {
    await ApiService.logout();

    Get.offAllNamed("/login");
  }
}