import 'package:flutter/material.dart';
import 'add_partner_screen.dart';
import 'partner_details_screen.dart';


class PartnersScreen extends StatelessWidget {
  final int? messId;

   PartnersScreen({super.key, this.messId});


  final List<Map<String, dynamic>> partners = [
    {
      "name": "Ravi Kumar",
      "status": "active",
      "phone": "+91 98765 11111",
      "email": "ravi@example.com",
      "deliveries": "245",
      "location": "Bangalore",
    },
    {
      "name": "Suresh Patil",
      "status": "active",
      "phone": "+91 98765 22222",
      "email": "suresh@example.com",
      "deliveries": "189",
      "location": "Bangalore",
    },
    {
      "name": "Vijay Reddy",
      "status": "inactive",
      "phone": "+91 98765 33333",
      "email": "vijay@example.com",
      "deliveries": "156",
      "location": "Bangalore",
    },
  ];

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

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Partners",
                        style: TextStyle(
                          fontSize: 22,
                          fontFamily: "",
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "${partners.length} delivery partners",
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                      )
                    ],
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const AddPartnerScreen(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.add, size: 18),
                    label: const Text("Add"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff2F6FED),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                    ),
                  )
                ],
              ),

              const SizedBox(height: 20),

              TextField(
                decoration: InputDecoration(
                  hintText: "Search customers...",
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding:
                  const EdgeInsets.symmetric(vertical: 0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Expanded(
                child: ListView.builder(
                  itemCount: partners.length,
                  itemBuilder: (_, index) {
                    final partner = partners[index];
                    return PartnerCard(partner: partner);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class PartnerCard extends StatelessWidget {
  final Map<String, dynamic> partner;

  const PartnerCard({super.key, required this.partner});

  @override
  Widget build(BuildContext context) {
    final bool isActive = partner["status"] == "active";

    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => PartnerDetailsScreen(
              name: partner["name"],
              phone: partner["phone"],
              email: partner["email"],
              address: partner["location"],
            ),
          ),
        );
      },
        child: Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    partner["name"],
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: isActive
                          ? Colors.black
                          : Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      partner["status"],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: const [
                  Icon(Icons.edit, size: 18),
                  SizedBox(width: 12),
                  Icon(Icons.delete, size: 18),
                  SizedBox(width: 12),
                  Icon(Icons.arrow_forward_ios, size: 16),
                ],
              )
            ],
          ),

          const SizedBox(height: 8),

          Text(
            partner["phone"],
            style: const TextStyle(color: Colors.grey),
          ),

          const SizedBox(height: 4),

          Text(
            partner["email"],
            style: const TextStyle(color: Colors.grey),
          ),

          const SizedBox(height: 12),
          const Divider(),
          const SizedBox(height: 8),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "TOTAL DELIVERIES",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    partner["deliveries"],
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "LOCATION",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    partner["location"],
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              )
            ],
          )
        ],
      ),
    ),
    );
  }
}
