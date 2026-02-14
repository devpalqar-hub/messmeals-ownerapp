import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DeliveriesScreen extends StatefulWidget {
  const DeliveriesScreen({super.key});

  @override
  State<DeliveriesScreen> createState() => _DeliveriesScreenState();
}

class _DeliveriesScreenState extends State<DeliveriesScreen> {
  String selectedStatus = "All Status";
  DateTime selectedDate = DateTime.now();

  final List<Map<String, dynamic>> deliveries = [
    {
      "name": "sona",
      "phone": "7954367123",
      "address": "addddsss",
      "price": "₹200",
      "meal": "breakfast",
      "status": "PENDING",
      "expanded": false,
    },
  ];

  /// ================= DATE PICKER =================
  Future pickDate() async {
    final picked = await showDatePicker(
      context: context,
      firstDate: DateTime(2024),
      lastDate: DateTime(2030),
      initialDate: selectedDate,
    );

    if (picked != null) {
      setState(() => selectedDate = picked);
    }
  }

  /// ================= GENERATE SHEET =================
  void openGenerateSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
      ),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Generate Deliveries",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 16),

              ListTile(
                title: const Text("Select date"),
                trailing: const Icon(Icons.calendar_today),
                onTap: pickDate,
              ),

              const SizedBox(height: 14),

              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  "This will create delivery records for all active customers.",
                ),
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 45),
                  backgroundColor: Colors.black,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Generate"),
              ),

              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel"),
              )
            ],
          ),
        );
      },
    );
  }

  /// ================= UI =================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F6FA),

      /// ================= APPBAR =================
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Deliveries",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: ElevatedButton.icon(
              onPressed: openGenerateSheet,
              icon: const Icon(Icons.add),
              label: const Text("Generate"),
            ),
          )
        ],
      ),

      /// ================= BODY =================
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// FILTER ROW
            Row(
              children: [
                /// STATUS DROPDOWN
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: selectedStatus,
                    items: const [
                      "All Status",
                      "Pending",
                      "Progress",
                      "Delivered"
                    ]
                        .map(
                          (e) => DropdownMenuItem(
                        value: e,
                        child: Text(e),
                      ),
                    )
                        .toList(),
                    onChanged: (v) => setState(() => selectedStatus = v!),
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                /// DATE BUTTON
                Expanded(
                  child: GestureDetector(
                    onTap: pickDate,
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(DateFormat('dd MMM yyyy').format(selectedDate)),
                          const Icon(Icons.calendar_today)
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),

            const SizedBox(height: 20),

            /// DELIVERY LIST
            Expanded(
              child: ListView.builder(
                itemCount: deliveries.length,
                itemBuilder: (_, index) {
                  return DeliveryCard(
                    delivery: deliveries[index],
                    onToggle: () {
                      setState(() {
                        deliveries[index]["expanded"] =
                        !deliveries[index]["expanded"];
                      });
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}









/// =====================================================
/// DELIVERY CARD
/// =====================================================

class DeliveryCard extends StatelessWidget {
  final Map<String, dynamic> delivery;
  final VoidCallback onToggle;

  const DeliveryCard({
    super.key,
    required this.delivery,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    final expanded = delivery["expanded"] == true;

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          /// BASIC INFO
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Chip(
                    label: Text(delivery["status"]),
                    backgroundColor: Colors.black,
                    labelStyle: const TextStyle(color: Colors.white),
                  ),
                  Text(delivery["name"],
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text(delivery["phone"]),
                  Text(delivery["address"]),
                ],
              ),

              Column(
                children: [
                  Text(delivery["price"]),
                  Text(delivery["meal"]),
                  IconButton(
                    icon: Icon(
                      expanded
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                    ),
                    onPressed: onToggle,
                  )
                ],
              )
            ],
          ),

          /// EXPANDED ACTIONS
          if (expanded) ...[
            const Divider(),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.map),
                    label: const Text("Open Map"),
                    onPressed: () {},
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.call),
                    label: const Text("Call Now"),
                    onPressed: () {},
                  ),
                ),
              ],
            )
          ]
        ],
      ),
    );
  }
}
