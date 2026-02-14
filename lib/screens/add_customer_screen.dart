import 'package:flutter/material.dart';

class AddCustomerScreen extends StatelessWidget {
  const AddCustomerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F6FA),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        title: const Text(
          "Add Customer",
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

                  /// ---------------- BASIC INFO ----------------
                  _card(
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text("Basic Information",
                            style: TextStyle(fontWeight: FontWeight.w600)),

                        SizedBox(height: 16),
                        _input("Name *", "Enter full name"),
                        _input("Phone *", "+91 98765 43210"),
                        _input("Email *", "email@example.com"),
                        _input("Address *", "Enter full address"),
                        _input("Latitude & Longitude", "Enter Lat & Long"),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  /// ---------------- PLAN & SUBSCRIPTION ----------------
                  _card(
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text("Plan & Subscription",
                            style: TextStyle(fontWeight: FontWeight.w600)),

                        SizedBox(height: 16),
                        _dropdown("Meal Plan *"),
                        _input("Start Date *", ""),
                        _input("End Date *", ""),
                        _dropdown("Delivery Partner *"),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  /// ---------------- WALLET ----------------
                  _card(
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text("Wallet",
                            style: TextStyle(fontWeight: FontWeight.w600)),
                        SizedBox(height: 12),
                        _input("Initial Wallet Amount", "0"),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  /// ---------------- DISCOUNT ----------------
                  _card(
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text("Discount",
                            style: TextStyle(fontWeight: FontWeight.w600)),
                        SizedBox(height: 12),
                        _input("Select discount amount", "0"),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            /// BUTTONS
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
                    child: const Text("Add Customer"),
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

/// ================= WIDGET HELPERS =================

Widget _card(Widget child) {
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
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label),
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

class _dropdown extends StatelessWidget {
  final String label;

  const _dropdown(this.label);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            decoration: BoxDecoration(
              color: const Color(0xffF2F3F7),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("Select"),
                Icon(Icons.keyboard_arrow_down),
              ],
            ),
          )
        ],
      ),
    );
  }
}
