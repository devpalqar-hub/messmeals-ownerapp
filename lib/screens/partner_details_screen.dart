import 'package:flutter/material.dart';

class PartnerDetailsScreen extends StatelessWidget {
  const PartnerDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F6FA),
      appBar: AppBar(
        backgroundColor: const Color(0xffF5F6FA),
        elevation: 0,
        leading: const Icon(Icons.arrow_back, color: Colors.black),
        title: const Text(
          "Partner Details",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          _actionBtn(Icons.edit, "Edit"),
          const SizedBox(width: 8),
          _actionBtn(Icons.delete_outline, "Delete"),
          const SizedBox(width: 10),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// PROFILE CARD
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Row(
                children: [
                  /// AVATAR
                  Container(
                    width: 60,
                    height: 60,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: const Color(0xffE6E6E6),
                      shape: BoxShape.circle,
                    ),
                    child: const Text(
                      "DE",
                      style:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),

                  const SizedBox(width: 14),

                  /// INFO
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "delivery 2",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      SizedBox(height: 6),
                      Row(
                        children: [
                          Icon(Icons.phone, size: 16, color: Colors.grey),
                          SizedBox(width: 6),
                          Text("1234567896",
                              style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(Icons.email, size: 16, color: Colors.grey),
                          SizedBox(width: 6),
                          Text("delivery2@gmail.com",
                              style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(Icons.location_on,
                              size: 16, color: Colors.grey),
                          SizedBox(width: 6),
                          Text("test 1",
                              style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),

            const SizedBox(height: 18),

            /// STATS GRID
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 14,
                crossAxisSpacing: 14,
                childAspectRatio: 1.2,
                children: const [
                  StatCard(
                    icon: Icons.check_circle_outline,
                    title: "COMPLETED",
                    value: "0",
                    color: Color(0xffE7F6EC),
                  ),
                  StatCard(
                    icon: Icons.inventory_2_outlined,
                    title: "TOTAL\nDELIVERIES",
                    value: "20",
                    color: Color(0xffEAF2FB),
                  ),
                  StatCard(
                    icon: Icons.trending_up,
                    title: "EARNINGS",
                    value: "₹0",
                    color: Color(0xffF3EAF7),
                  ),
                  StatCard(
                    icon: Icons.calendar_today_outlined,
                    title: "PENDING",
                    value: "20",
                    color: Color(0xffFFF3E6),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  /// ACTION BUTTON
  Widget _actionBtn(IconData icon, String label) {
    return OutlinedButton.icon(
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        side: const BorderSide(color: Color(0xffE0E0E0)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onPressed: () {},
      icon: Icon(icon, size: 18),
      label: Text(label),
    );
  }
}
class StatCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final Color color;

  const StatCard({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration:
            BoxDecoration(color: color, borderRadius: BorderRadius.circular(12)),
            child: Icon(icon, size: 22),
          ),
          const SizedBox(height: 10),
          Text(title,
              style: const TextStyle(color: Colors.grey, fontSize: 12)),
          const Spacer(),
          Text(value,
              style:
              const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}