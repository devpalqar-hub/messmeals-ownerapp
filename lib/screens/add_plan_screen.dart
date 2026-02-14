import 'package:flutter/material.dart';

class AddPlanScreen extends StatelessWidget {
  const AddPlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F6FA),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        title: const Text(
          "Add Plan",
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

                  _input("Plan Name *"),
                  _input("Price *", number: true),
                  _input("Minimum Price", number: true),

                  /// Description
                  _textarea("Description"),

                  _input("Image URL", hint: "https://example.com/image.jpg"),

                  const SizedBox(height: 16),

                  /// Delivery variations
                  const Text(
                    "Delivery Variations *",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 10),

                  _checkbox("Lunch"),
                  _checkbox("Dinner"),
                  _checkbox("Both"),
                ],
              ),
            ),

            /// Buttons
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
                      backgroundColor: Colors.black,
                    ),
                    child: const Text("Save"),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

/// ================= Widgets =================

Widget _input(String label, {bool number = false, String? hint}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 14),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(height: 6),
        TextField(
          keyboardType:
          number ? TextInputType.number : TextInputType.text,
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

Widget _textarea(String label) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 14),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(height: 6),
        TextField(
          maxLines: 4,
          decoration: InputDecoration(
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

Widget _checkbox(String text) {
  return Row(
    children: [
      Checkbox(value: false, onChanged: (_) {}),
      Text(text),
    ],
  );
}
