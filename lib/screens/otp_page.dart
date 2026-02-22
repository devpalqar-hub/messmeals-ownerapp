import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../service/api_service.dart';

class OtpScreen extends StatelessWidget {
  OtpScreen({super.key});

  final TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final String phone = Get.arguments;

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
                const Text("Verify OTP"),
                const SizedBox(height: 20),

                TextField(
                  controller: otpController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      hintText: "Enter OTP",
                      border: OutlineInputBorder()),
                ),

                const SizedBox(height: 20),

                ElevatedButton(
                  onPressed: () async {
                    try {
                      final success = await ApiService.verifyOtp(
                          phone, otpController.text);

                      if (success) {
                        Get.offAllNamed("/main");
                      }
                    } catch (e) {
                      Get.snackbar("Error", e.toString());
                    }
                  },
                  child: const Text("Verify"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}