import 'package:flutter/material.dart';
import 'add_customer_screen.dart';
import 'customer_details_screen.dart';


class CustomersScreen extends StatelessWidget {
  CustomersScreen({super.key});

  final List<Map<String, String>> customers = [
    {
      "name": "Rahul Sharma",
      "phone": "+91 98765 43210",
      "email": "rahul@example.com",
      "wallet": "₹1500",
      "plan": "Basic Plan",
      "start": "01/10/2025",
      "end": "31/10/2025",
    },
    {
      "name": "Priya Singh",
      "phone": "+91 98765 43211",
      "email": "priya@example.com",
      "wallet": "₹2500",
      "plan": "Premium Plan",
      "start": "01/10/2025",
      "end": "31/10/2025",
    },
    {
      "name": "Amit Kumar",
      "phone": "+91 98765 43212",
      "email": "amit@example.com",
      "wallet": "₹1200",
      "plan": "Lunch Only",
      "start": "01/10/2025",
      "end": "31/10/2025",
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

              /// ---------------- HEADER ----------------
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Customers",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "${customers.length} total",
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const AddCustomerScreen(),
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
                    ),
                  )
                ],
              ),

              const SizedBox(height: 20),

              /// ---------------- SEARCH + FILTER ----------------
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Search customers...",
                        prefixIcon: const Icon(Icons.search),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.zero,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Row(
                      children: const [
                        Text("All Plans"),
                        SizedBox(width: 6),
                        Icon(Icons.keyboard_arrow_down, size: 18),
                      ],
                    ),
                  )
                ],
              ),

              const SizedBox(height: 20),

              /// ---------------- LIST ----------------
              Expanded(
                child: ListView.builder(
                  itemCount: customers.length,
                  itemBuilder: (_, index) {
                    final customer = customers[index];
                    return CustomerCard(customer: customer);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}


class CustomerCard extends StatelessWidget {
  final Map<String, String> customer;

  const CustomerCard({super.key, required this.customer});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => CustomerDetailsScreen(
                name: customer["name"]!,
                phone: customer["phone"]!,
                email: customer["email"]!,
                address: "Bangalore", // add address if needed
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

          /// Name + icons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                customer["name"]!,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
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

          Text(customer["phone"]!, style: const TextStyle(color: Colors.grey)),
          const SizedBox(height: 4),
          Text(customer["email"]!, style: const TextStyle(color: Colors.grey)),

          const SizedBox(height: 12),
          const Divider(),
          const SizedBox(height: 12),

          /// Bottom Info
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _info("WALLET", customer["wallet"]!),
              _info("PLAN", customer["plan"]!),
            ],
          ),

          const SizedBox(height: 12),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _info("START DATE", customer["start"]!),
              _info("END DATE", customer["end"]!),
            ],
          )
        ],
      ),
    ),
    );
  }
}

Widget _info(String title, String value) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: const TextStyle(
          fontSize: 12,
          color: Colors.grey,
        ),
      ),
      const SizedBox(height: 4),
      Text(
        value,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
    ],
  );
}
