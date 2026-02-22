import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../service/api_service.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F6FA),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: const Color(0xffE5E5E5)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xff3B6EA5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.restaurant, color: Colors.white),
                ),
                const SizedBox(height: 12),
                const Text("SuperMeals Admin",
                    style:
                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                const Text("Sign in to your account",
                    style: TextStyle(color: Colors.grey)),
                const SizedBox(height: 20),

                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text("PHONE NUMBER",
                      style: TextStyle(fontWeight: FontWeight.w500)),
                ),
                const SizedBox(height: 6),

                TextField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText: "Enter phone number",
                    filled: true,
                    fillColor: const Color(0xffF1F3F6),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none),
                  ),
                ),

                const SizedBox(height: 18),

                /// ⭐ LOGIN BUTTON
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff3B6EA5),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    onPressed: () async {
                      if (phoneController.text.isEmpty) {
                        Get.snackbar("Error", "Enter phone number");
                        return;
                      }

                      try {
                        final success =
                        await ApiService.sendLoginOtp(phoneController.text);

                        if (success) {
                          Get.toNamed("/otp",
                              arguments: phoneController.text);
                        }
                      } catch (e) {
                        Get.snackbar("Error", e.toString());
                      }
                    },
                    child: const Text("LOGIN"),
                  ),
                ),

                const SizedBox(height: 12),
                const Text("Forgot password?",
                    style: TextStyle(color: Colors.black54))
              ],
            ),
          ),
        ),
      ),
    );
  }
}