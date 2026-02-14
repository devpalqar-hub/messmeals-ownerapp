import 'package:flutter/material.dart';

class PartnerDetailsScreen extends StatelessWidget {
  final String name;
  final String phone;
  final String email;
  final String address;

  const PartnerDetailsScreen({
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

      /// ================= APP BAR =================
      appBar: AppBar(
        backgroundColor: const Color(0xffF5F6FA),
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        title: const Text(
          "Partner Details",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            /// ================= PROFILE CARD =================
            _card(
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 28,
                    backgroundColor: Color(0xffE2E2E2),
                    child: Text("RS"),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(name,
                            style: const TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 16)),
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
                _statCard("Completed", "1231", Icons.check_circle,
                    Colors.green),
                const SizedBox(width: 12),
                _statCard("Total Deliveries", "245", Icons.inventory_2,
                    Colors.blue),
              ],
            ),

            const SizedBox(height: 12),

            Row(
              children: [
                _statCard("Earnings", "₹10,023", Icons.currency_rupee,
                    Colors.purple),
                const SizedBox(width: 12),
                _statCard("Pending", "1", Icons.calendar_today,
                    Colors.orange),
              ],
            ),

            const SizedBox(height: 16),

            /// ================= PERFORMANCE =================
            _card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Performance Metrics",
                      style:
                      TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),

                  const SizedBox(height: 12),

                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Completion Rate"),
                      Text("50.0%"),
                    ],
                  ),

                  const SizedBox(height: 8),

                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: 0.5,
                      minHeight: 8,
                      backgroundColor: Colors.grey.shade300,
                      color: const Color(0xff2F6FED),
                    ),
                  ),

                  const SizedBox(height: 16),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      _miniStat("1", "Completed"),
                      _miniStat("0", "In Progress"),
                      _miniStat("1", "Pending"),
                    ],
                  )
                ],
              ),
            ),

            const SizedBox(height: 16),

            /// ================= RECENT DELIVERIES =================
            _card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text("Recent Deliveries",
                      style:
                      TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                  SizedBox(height: 12),
                  _deliveryRow("pending", "Delivery #1", "₹100", false),
                  SizedBox(height: 8),
                  _deliveryRow("completed", "Delivery #1", "₹100", true),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  /// ================= COMMON WIDGETS =================

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

  Widget _rowIcon(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 14, color: Colors.grey),
        const SizedBox(width: 6),
        Text(text, style: const TextStyle(color: Colors.grey)),
      ],
    );
  }

  Widget _statCard(
      String title, String value, IconData icon, Color color) {
    return Expanded(
      child: _card(
        child: Column(
          children: [
            Icon(icon, color: color),
            const SizedBox(height: 6),
            Text(title,
                style: const TextStyle(fontSize: 11, color: Colors.grey)),
            const SizedBox(height: 6),
            Text(value,
                style:
                const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          ],
        ),
      ),
    );
  }
}

/// mini stat
class _miniStat extends StatelessWidget {
  final String value;
  final String label;

  const _miniStat(this.value, this.label);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value,
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 16)),
        Text(label, style: const TextStyle(color: Colors.grey)),
      ],
    );
  }
}

/// delivery row
class _deliveryRow extends StatelessWidget {
  final String status;
  final String title;
  final String amount;
  final bool completed;

  const _deliveryRow(this.status, this.title, this.amount, this.completed);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Chip(
              label: Text(status),
              backgroundColor:
              completed ? const Color(0xffC8E6C9) : Colors.grey.shade300,
            ),
            const SizedBox(width: 10),
            Text(title),
          ],
        ),
        Text(amount),
      ],
    );
  }
}