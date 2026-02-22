import 'package:flutter/material.dart';

class CustomerDetailsScreen extends StatelessWidget {
  const CustomerDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F6FA),
      appBar: AppBar(
        backgroundColor: const Color(0xffF5F6FA),
        elevation: 0,
        leading: const Icon(Icons.arrow_back, color: Colors.black),
        title: const Text("Customer Details",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        actions: [
          _action(Icons.edit, "Edit"),
          const SizedBox(width: 8),
          _action(Icons.delete_outline, "Delete"),
          const SizedBox(width: 10),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// PROFILE CARD
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18)),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: Colors.grey.shade300,
                    child: const Text("RS",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text("Rahul Sharma",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(Icons.phone, size: 16, color: Colors.grey),
                          SizedBox(width: 4),
                          Text("+91 98765 43210",
                              style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.email, size: 16, color: Colors.grey),
                          SizedBox(width: 4),
                          Text("rahul@example.com",
                              style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.location_on,
                              size: 16, color: Colors.grey),
                          SizedBox(width: 4),
                          Text("123 MG Road, Bangalore",
                              style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),

            const SizedBox(height: 14),

            /// WALLET + PLAN
            Row(
              children: const [
                Expanded(child: _InfoCard("WALLET\nBALANCE", "₹20000", Icons.account_balance_wallet)),
                SizedBox(width: 10),
                Expanded(child: _InfoCard("PLAN\nPRICE", "₹1500", Icons.inventory_2_outlined)),
              ],
            ),

            const SizedBox(height: 10),

            /// SPENT + DAYS
            Row(
              children: const [
                Expanded(child: _InfoCard("TOTAL\nSPENT", "₹100", Icons.credit_card)),
                SizedBox(width: 10),
                Expanded(child: _InfoCard("DAYS\nLEFT", "7", Icons.calendar_today)),
              ],
            ),

            const SizedBox(height: 14),

            /// SUBSCRIPTION DETAILS
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Subscription Details",
                      style: TextStyle(fontWeight: FontWeight.bold)),

                  const SizedBox(height: 10),

                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _Detail("CURRENT PLAN", "Basic Plan"),
                      _Detail("PLAN PRICE", "₹3000"),
                    ],
                  ),

                  const SizedBox(height: 10),

                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _Detail("START DATE", "Oct 1, 2025"),
                      _Detail("END DATE", "Oct 31, 2025"),
                    ],
                  ),

                  const SizedBox(height: 10),

                  const Text("Plan Variations",
                      style: TextStyle(color: Colors.grey)),

                  const SizedBox(height: 6),

                  Wrap(
                    spacing: 6,
                    children: const [
                      Chip(label: Text("Lunch")),
                      Chip(label: Text("Dinner")),
                    ],
                  ),

                  const SizedBox(height: 12),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff3B6EA5),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: () {},
                      child: const Text("Renew Subscription"),
                    ),
                  ),

                  const SizedBox(height: 10),

                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {},
                      child: const Text("Cancel Subscription"),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 14),

            /// RECENT DELIVERY
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text("Recent Deliveries",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Chip(label: Text("completed")),
                      Text("₹100"),
                    ],
                  ),
                  Text("Delivery #1", style: TextStyle(fontWeight: FontWeight.bold)),
                  Text("Oct 16, 2025", style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _action(IconData icon, String label) {
    return OutlinedButton.icon(
      onPressed: () {},
      icon: Icon(icon, size: 18),
      label: Text(label),
    );
  }
}
class _InfoCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const _InfoCard(this.title, this.value, this.icon);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration:
      BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.grey),
          const SizedBox(height: 8),
          Text(title, style: const TextStyle(color: Colors.grey, fontSize: 12)),
          const SizedBox(height: 4),
          Text(value,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        ],
      ),
    );
  }
}

class _Detail extends StatelessWidget {
  final String title;
  final String value;

  const _Detail(this.title, this.value);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 11, color: Colors.grey)),
        const SizedBox(height: 2),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }
}