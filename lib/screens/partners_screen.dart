import 'package:flutter/material.dart';
import '../service/api_service.dart';
import 'add_partner_screen.dart';
import 'partner_details_screen.dart';

class PartnersScreen extends StatefulWidget {
  final String? messId;

  const PartnersScreen({super.key, this.messId});

  @override
  State<PartnersScreen> createState() => _PartnersScreenState();
}

class _PartnersScreenState extends State<PartnersScreen> {
  List<dynamic> partners = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchPartners();
  }

  @override
  void didUpdateWidget(covariant PartnersScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.messId != widget.messId && widget.messId != null) {
      fetchPartners();
    }
  }

  Future<void> fetchPartners() async {
    if (widget.messId == null) return;

    try {
      setState(() => isLoading = true);

      final response = await ApiService.getPartners(widget.messId!);
      partners = response["data"] ?? [];

      debugPrint("Partners fetched for mess: ${widget.messId}");
    } catch (e) {
      debugPrint("Partners fetch error: $e");
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
              /// Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${partners.length} Partners",
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.w600),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              AddPartnerScreen(messId: widget.messId!),
                        ),
                      ).then((_) => fetchPartners());
                    },
                    icon: const Icon(Icons.add, size: 18),
                    label: const Text("Add"),
                  )
                ],
              ),

              const SizedBox(height: 20),

              /// List
              Expanded(
                child: partners.isEmpty
                    ? const Center(child: Text("No partners found"))
                    : ListView.builder(
                  itemCount: partners.length,
                  itemBuilder: (_, index) {
                    final partner = partners[index];

                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => PartnerDetailsScreen(
                              messId: widget.messId!,
                              partnerId: partner["id"]?.toString(),
                              name: partner["name"] ?? "",
                              phone: partner["phone"] ?? "",
                              email: partner["email"] ?? "",
                              address: partner["location"] ?? "",
                            ),
                          ),
                        ).then((_) => fetchPartners());
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border:
                          Border.all(color: Colors.grey.shade300),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              partner["name"] ?? "",
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              partner["phone"] ?? "",
                              style:
                              const TextStyle(color: Colors.grey),
                            ),
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