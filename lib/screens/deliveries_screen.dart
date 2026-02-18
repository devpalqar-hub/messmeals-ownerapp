import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DeliveriesScreen extends StatefulWidget {
  final int? messId;

  const DeliveriesScreen({super.key, this.messId});

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


  Future<void> pickDate() async {
    final picked = await showDatePicker(
      context: context,
      firstDate: DateTime(2024),
      lastDate: DateTime(2030),
      initialDate: selectedDate,
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

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

  @override
  Widget build(BuildContext context) {

    // If no mess selected
    if (widget.messId == null) {
      return const Center(
        child: Text(
          "Please select a mess",
          style: TextStyle(fontSize: 16),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xffF5F6FA),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Deliveries",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
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

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            Row(
              children: [

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
                    onChanged: (v) {
                      setState(() {
                        selectedStatus = v!;
                      });
                    },
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: GestureDetector(
                    onTap: pickDate,
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            DateFormat('dd MMM yyyy')
                                .format(selectedDate),
                          ),
                          const Icon(Icons.calendar_today)
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),

            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: deliveries.length,
                itemBuilder: (_, index) {
                  return DeliveryCard(
                    delivery: deliveries[index],
                    onToggle: () {
                      setState(() {
                        deliveries[index]["expanded"] =
                        !(deliveries[index]["expanded"] ?? false);
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
    final bool expanded = delivery["expanded"] == true;

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Chip(
                    label: Text(delivery["status"]),
                    backgroundColor: Colors.black,
                    labelStyle:
                    const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    delivery["name"],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
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
