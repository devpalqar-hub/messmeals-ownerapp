import 'package:flutter/material.dart';

class PartnersScreen extends StatelessWidget {
  const PartnersScreen({super.key, String? messId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F6FA),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// HEADER
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Partners",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "3 delivery partners",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff3B6EA5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {},
                    icon: const Icon(Icons.add),
                    label: const Text("Add"),
                  )
                ],
              ),

              const SizedBox(height: 16),

              /// SEARCH
              TextField(
                decoration: InputDecoration(
                  hintText: "Search customers...",
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(vertical: 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 16),

              /// LIST
              const Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      PartnerCard(
                        name: "Ravi Kumar",
                        phone: "+91 98765 11111",
                        email: "ravi@example.com",
                        deliveries: "245",
                        location: "Bangalore",
                        isActive: true,
                      ),
                      PartnerCard(
                        name: "Suresh Patil",
                        phone: "+91 98765 22222",
                        email: "suresh@example.com",
                        deliveries: "189",
                        location: "Bangalore",
                        isActive: true,
                      ),
                      PartnerCard(
                        name: "Vijay Reddy",
                        phone: "+91 98765 33333",
                        email: "",
                        deliveries: "156",
                        location: "",
                        isActive: false,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
class PartnerCard extends StatelessWidget {
  final String name;
  final String phone;
  final String email;
  final String deliveries;
  final String location;
  final bool isActive;

  const PartnerCard({
    super.key,
    required this.name,
    required this.phone,
    required this.email,
    required this.deliveries,
    required this.location,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// NAME + STATUS
          Row(
            children: [
              Expanded(
                child: Text(
                  name,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: isActive ? Colors.black : Colors.grey,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  isActive ? "active" : "inactive",
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
              const SizedBox(width: 6),
              const Icon(Icons.edit_outlined, size: 18),
              const SizedBox(width: 10),
              const Icon(Icons.delete_outline, size: 18),
              const SizedBox(width: 6),
              const Icon(Icons.chevron_right),
            ],
          ),

          const SizedBox(height: 6),

          /// PHONE + EMAIL
          Text(phone, style: const TextStyle(color: Colors.grey)),
          if (email.isNotEmpty)
            Text(email, style: const TextStyle(color: Colors.grey)),

          const SizedBox(height: 10),
          const Divider(),

          /// FOOTER
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _infoColumn("TOTAL DELIVERIES", deliveries),
              _infoColumn("LOCATION", location),
            ],
          )
        ],
      ),
    );
  }

  Widget _infoColumn(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: const TextStyle(fontSize: 11, color: Colors.grey)),
        const SizedBox(height: 2),
        Text(value,
            style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }
}