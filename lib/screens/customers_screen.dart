import 'package:flutter/material.dart';
import '../service/api_service.dart';
import 'add_customer_screen.dart';
import 'customer_details_screen.dart';

class CustomersScreen extends StatefulWidget {
  final String? messId;

  const CustomersScreen({super.key, this.messId});

  @override
  State<CustomersScreen> createState() => _CustomersScreenState();
}

class _CustomersScreenState extends State<CustomersScreen> {
  List<dynamic> customers = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchCustomers();
  }

  @override
  void didUpdateWidget(covariant CustomersScreen oldWidget) {
    super.didUpdateWidget(oldWidget);

    /// Refresh when mess changes
    if (oldWidget.messId != widget.messId && widget.messId != null) {
      fetchCustomers();
    }
  }

  /// ⭐ FETCH CUSTOMERS
  Future<void> fetchCustomers() async {
    if (widget.messId == null) return;

    try {
      setState(() => isLoading = true);

      /// ✅ FIX: messId! because already null checked
      final response = await ApiService.getCustomers(widget.messId!);
      customers = response["data"] ?? [];
    } catch (e) {
      debugPrint("Customer fetch error: $e");
    } finally {
      setState(() => isLoading = false);
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              /// ⭐ HEADER
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("${customers.length} Customers",
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.w600)),

                  /// ⭐ ADD BUTTON
                  ElevatedButton.icon(
                    onPressed: () async {
                      /// Navigate and refresh after add
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              AddCustomerScreen(messId: widget.messId!),
                        ),
                      );

                      fetchCustomers();
                    },
                    icon: const Icon(Icons.add, size: 18),
                    label: const Text("Add"),
                  )
                ],
              ),

              const SizedBox(height: 20),

              /// ⭐ LIST
              Expanded(
                child: customers.isEmpty
                    ? const Center(child: Text("No customers found"))
                    : ListView.builder(
                  itemCount: customers.length,
                  itemBuilder: (_, index) {
                    final customer = customers[index];

                    return InkWell(
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => CustomerDetailsScreen(
                              name: customer["name"] ?? "",
                              phone: customer["phone"] ?? "",
                              email: customer["email"] ?? "",
                              address: customer["address"] ?? "",
                            ),
                          ),
                        );

                        fetchCustomers();
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
                            Text(customer["name"] ?? "",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16)),
                            const SizedBox(height: 6),
                            Text(customer["phone"] ?? "",
                                style: const TextStyle(
                                    color: Colors.grey)),
                          ],
                        ),
                      ),
                    );
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