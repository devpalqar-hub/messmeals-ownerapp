import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../service/api_service.dart';

class DeliveriesScreen extends StatefulWidget {
  final String? messId;

  const DeliveriesScreen({super.key, this.messId});

  @override
  State<DeliveriesScreen> createState() => _DeliveriesScreenState();
}

class _DeliveriesScreenState extends State<DeliveriesScreen> {
  String selectedStatus = "All Status";
  DateTime selectedDate = DateTime.now();

  List<dynamic> deliveries = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchDeliveries();
  }

  /// ⭐ REFRESH WHEN MESS CHANGES
  @override
  void didUpdateWidget(covariant DeliveriesScreen oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.messId != widget.messId) {
      fetchDeliveries();
    }
  }

  /// ⭐ API CALL
  Future<void> fetchDeliveries() async {
    if (widget.messId == null) return;

    try {
      setState(() => isLoading = true);

      final response = await ApiService.authorizedGet(
          "/deliveries?mess_id=${widget.messId}");

      deliveries = response["data"] ?? [];

      debugPrint("Deliveries fetched for mess: ${widget.messId}");
    } catch (e) {
      debugPrint("Deliveries error: $e");
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> pickDate() async {
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

  @override
  Widget build(BuildContext context) {
    if (widget.messId == null) {
      return const Center(child: Text("Select a mess"));
    }

    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      backgroundColor: const Color(0xffF5F6FA),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: deliveries.isEmpty
            ? const Center(child: Text("No deliveries found"))
            : ListView.builder(
          itemCount: deliveries.length,
          itemBuilder: (_, index) {
            final delivery = deliveries[index];
            return DeliveryCard(delivery: delivery);
          },
        ),
      ),
    );
  }
}

class DeliveryCard extends StatelessWidget {
  final dynamic delivery;

  const DeliveryCard({super.key, required this.delivery});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(delivery["customerName"] ?? "",
              style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          Text(delivery["status"] ?? ""),
        ],
      ),
    );
  }
}
