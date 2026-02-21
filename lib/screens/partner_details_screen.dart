import 'package:flutter/material.dart';
import '../service/api_service.dart';

class PartnerDetailsScreen extends StatelessWidget {
  final String? messId;
  final String? partnerId;
  final String name;
  final String phone;
  final String email;
  final String address;

  const PartnerDetailsScreen({
    super.key,
    this.messId,
    this.partnerId,
    required this.name,
    required this.phone,
    required this.email,
    required this.address,
  });


  Future<void> deletePartner(BuildContext context) async {
    if (partnerId == null) return;

    try {
      await ApiService.authorizedPost(
        "/partners/delete",
        {"partner_id": partnerId, "mess_id": messId},
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Partner deleted")),
      );

      Navigator.pop(context);
    } catch (e) {
      debugPrint("Delete error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F6FA),

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
            onPressed: () {
              /// ⭐ future edit screen
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.black),
            onPressed: () => deletePartner(context),
          ),
        ],
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
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

              _card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Performance Metrics",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 16)),
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
                        backgroundColor: Colors.grey,
                        color: const Color(0xff2F6FED),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

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
