import 'package:flutter/material.dart';

class CustomersScreen extends StatelessWidget {
  final String? messId;
  const CustomersScreen({super.key, this.messId});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 20),
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
                  Text("Customers",
                      style:
                      TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  SizedBox(height: 4),
                  Text("3 customers",
                      style: TextStyle(color: Colors.grey)),
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

          const SizedBox(height: 14),

          /// SEARCH
          TextField(
            decoration: InputDecoration(
              hintText: "Search customers...",
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: const Color(0xffF1F3F6),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),

          const SizedBox(height: 14),

          /// LIST
          const CustomerCard(),
          const CustomerCard(active: true),
          const CustomerCard(active: false),
        ],
      ),
    );
  }
}
class CustomerCard extends StatelessWidget {
  final bool active;

  const CustomerCard({super.key, this.active = true});

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
              const Expanded(
                child: Text(
                  "Ravi Kumar",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: active ? Colors.black : Colors.grey,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  active ? "active" : "inactive",
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
          const Text("+91 98765 11111", style: TextStyle(color: Colors.grey)),
          const Text("ravi@example.com",
              style: TextStyle(color: Colors.grey)),

          const SizedBox(height: 10),
          const Divider(),

          /// FOOTER
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              _Info("TOTAL DELIVERIES", "245"),
              _Info("LOCATION", "Bangalore"),
            ],
          )
        ],
      ),
    );
  }
}
class _Info extends StatelessWidget {
  final String title;
  final String value;

  const _Info(this.title, this.value);

  @override
  Widget build(BuildContext context) {
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