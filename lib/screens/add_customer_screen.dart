import 'package:flutter/material.dart';

class AddCustomerScreen extends StatelessWidget {
  const AddCustomerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F6FA),

      /// APP BAR
      appBar: AppBar(
        backgroundColor: const Color(0xffF5F6FA),
        elevation: 0,
        leading: const Icon(Icons.arrow_back, color: Colors.black),
        title: const Text(
          "Add Customer",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// BASIC INFO
            _card(
              "Basic Information",
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _label("Name"),
                  _field("Enter full name"),
                  const SizedBox(height: 10),

                  _label("Phone *"),
                  _field("+91 98765 43210"),
                  const SizedBox(height: 10),

                  _label("Email *"),
                  _field("email@example.com"),
                  const SizedBox(height: 10),

                  _label("Address *"),
                  _field("Enter full address", max: 2),
                  const SizedBox(height: 10),

                  _buttonGrey("Get Current Location"),
                  const SizedBox(height: 6),

                  const Center(child: Text("or")),
                  const SizedBox(height: 6),

                  _field("Enter Latitude And Longitude"),
                ],
              ),
            ),

            const SizedBox(height: 14),

            /// PLAN & SUB
            _card(
              "Plan & Subscription",
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _label("Meal Plan *"),
                  _dropdown("Select plan"),
                  const SizedBox(height: 10),

                  Row(
                    children: [
                      Expanded(child: _field("Start Date *")),
                      const SizedBox(width: 10),
                      Expanded(child: _field("End Date *")),
                    ],
                  ),

                  const SizedBox(height: 10),
                  _label("Delivery Partner *"),
                  _dropdown("Select partner"),
                ],
              ),
            ),

            const SizedBox(height: 14),

            /// WALLET
            _card(
              "Wallet",
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _label("Initial Wallet Amount"),
                  _field("0"),
                ],
              ),
            ),

            const SizedBox(height: 14),

            /// DISCOUNT
            _card(
              "Discount",
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _label("Select discount amount"),
                  _field("0"),
                ],
              ),
            ),

            const SizedBox(height: 16),

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
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff3B6EA5),
                    ),
                    onPressed: () {},
                    child: const Text("Add Customer"),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  /// CARD
  Widget _card(String title, Widget child) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration:
      BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          child
        ],
      ),
    );
  }

  /// LABEL
  Widget _label(String text) {
    return Text(text, style: const TextStyle(fontWeight: FontWeight.w500));
  }

  /// FIELD
  Widget _field(String hint, {int max = 1}) {
    return TextField(
      maxLines: max,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: const Color(0xffF1F3F6),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  /// DROPDOWN
  Widget _dropdown(String hint) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xffF1F3F6),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(hint),
          const Icon(Icons.keyboard_arrow_down),
        ],
      ),
    );
  }

  /// GREY BUTTON
  Widget _buttonGrey(String text) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xffF1F3F6),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(child: Text(text)),
    );
  }
}