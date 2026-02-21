import 'package:flutter/material.dart';

class AddPartnerScreen extends StatelessWidget {
  const AddPartnerScreen({super.key, String? messId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F6FA),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        title: const Text(
          "Add Partners",
          style: TextStyle(color: Colors.black),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            /// FORM
            Expanded(
              child: ListView(
                children: [

                  /// ---------------- Basic Info Card ----------------
                  _card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text("Basic Information",
                            style: TextStyle(fontWeight: FontWeight.w600)),

                        SizedBox(height: 16),
                        _input("Name *", "Enter full name"),
                        _input("Phone *", "+91 98765 43210"),
                        _input("Email", "email@example.com"),
                        _input("Address", "Enter address"),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// ---------------- Status Card ----------------
                  _card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text("Status",
                            style: TextStyle(fontWeight: FontWeight.w600)),

                        SizedBox(height: 16),
                        _input("Current Status *", "Active"),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            /// ---------------- Buttons ----------------
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Cancel"),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff2F6FED),
                    ),
                    child: const Text("Add Partner"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// ================= UI helpers =================

Widget _card({required Widget child}) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: child,
  );
}

class _input extends StatelessWidget {
  final String label;
  final String hint;

  const _input(this.label, this.hint);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 12)),
          const SizedBox(height: 6),
          TextField(
            decoration: InputDecoration(
              hintText: hint,
              filled: true,
              fillColor: const Color(0xffF2F3F7),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
          )
        ],
      ),
    );
  }
}
