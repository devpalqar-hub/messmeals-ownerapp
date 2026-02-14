import 'package:flutter/material.dart';

class CustomerDetailsScreen extends StatelessWidget {
  final String name;
  final String phone;
  final String email;
  final String address;

  const CustomerDetailsScreen({
    super.key,
    required this.name,
    required this.phone,
    required this.email,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F6FA),

      /// ================= APPBAR =================
      appBar: AppBar(
        backgroundColor: const Color(0xffF5F6FA),
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        title: const Text(
          "Customer Details",
          style: TextStyle(color: Colors.black),
        ),
        actions: const [
          Icon(Icons.edit, color: Colors.black),
          SizedBox(width: 10),
          Icon(Icons.delete, color: Colors.black),
          SizedBox(width: 10),
        ],
      ),

      /// ================= BODY =================
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 110),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// ================= PROFILE =================
            _card(
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 26,
                    backgroundColor: Color(0xffE2E2E2),
                    child: Text("RS"),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(name,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600)),
                        const SizedBox(height: 6),
                        _rowIcon(Icons.call, phone),
                        _rowIcon(Icons.email, email),
                        _rowIcon(Icons.location_on, address),
                      ],
                    ),
                  )
                ],
              ),
            ),

            const SizedBox(height: 16),

            /// ================= STATS GRID =================
            Row(
              children: [
                Expanded(child: _walletCard()),
                const SizedBox(width: 12),
                Expanded(child: _infoCard("TOTAL ORDERS", "1", Icons.inventory)),
              ],
            ),

            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(child: _infoCard("TOTAL SPENT", "₹100", Icons.currency_rupee)),
                const SizedBox(width: 12),
                Expanded(child: _infoCard("DAYS LEFT", "7", Icons.calendar_today)),
              ],
            ),

            const SizedBox(height: 16),

            /// ================= SUBSCRIPTION =================
            _subscriptionCard(),

            const SizedBox(height: 16),

            /// ================= RECENT =================
            _card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Row(
                    children: [
                      Chip(
                        label: Text("completed"),
                        backgroundColor: Color(0xffC8E6C9),
                      ),
                      SizedBox(width: 8),
                      Text("Delivery #1"),
                    ],
                  ),
                  Text("₹100"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// ================= WIDGETS =================

  Widget _walletCard() {
    return SizedBox(
      height: 115, // ⭐ forces equal height
      child: _card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.account_balance_wallet,
                color: Colors.green, size: 22),

            const SizedBox(height: 4),

            const Text("WALLET BALANCE",
                style: TextStyle(fontSize: 11, color: Colors.grey)),

            const SizedBox(height: 2),

            const Text("₹20000",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),

            const SizedBox(height: 6),

            SizedBox(
              height: 26,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff2F6FED),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                ),
                child: const Text("Add money",
                    style: TextStyle(fontSize: 11)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoCard(String title, String value, IconData icon) {
    return SizedBox(
      height: 115, // ⭐ SAME height as wallet
      child: _card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 22),

            const SizedBox(height: 6),

            Text(title,
                style: const TextStyle(fontSize: 11, color: Colors.grey)),

            const SizedBox(height: 4),

            Text(value,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 16)),
          ],
        ),
      ),
    );
  }
  Widget _subscriptionCard() {
    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Subscription Details",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
          const SizedBox(height: 14),

          _twoCol("Current Plan", "Basic Plan"),
          _twoCol("Plan Price", "₹3000"),
          _twoCol("Start Date", "Oct 1, 2025"),
          _twoCol("End Date", "Oct 31, 2025"),

          const SizedBox(height: 12),

          Wrap(
            spacing: 8,
            children: const [
              Chip(label: Text("Lunch")),
              Chip(label: Text("Dinner")),
            ],
          ),

          const SizedBox(height: 14),

          _primaryBtn("Renew Subscription"),
          const SizedBox(height: 10),
          _outlineBtn("Pause Subscription", const Color(0xff2F6FED)),
          const SizedBox(height: 10),
          _outlineBtn("Cancel Subscription", Colors.red),
        ],
      ),
    );
  }

  Widget _primaryBtn(String text) => SizedBox(
    width: double.infinity,
    height: 44,
    child: ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xff2F6FED),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Text(text),
    ),
  );

  Widget _outlineBtn(String text, Color color) => SizedBox(
    width: double.infinity,
    height: 44,
    child: OutlinedButton(
      onPressed: () {},
      style: OutlinedButton.styleFrom(
        foregroundColor: color,
        side: BorderSide(color: color),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Text(text),
    ),
  );

  Widget _card({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: child,
    );
  }

  Widget _rowIcon(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 14, color: Colors.grey),
        const SizedBox(width: 6),
        Text(text, style: const TextStyle(color: Colors.grey)),
      ],
    );
  }

  Widget _twoCol(String a, String b) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(a),
          Text(b, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}