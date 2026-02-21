import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/plansController.dart';
import '../models/mess_plan_model.dart';
import 'add_plan_screen.dart';

class PlansScreen extends StatefulWidget {
  final String? messId;

  const PlansScreen({super.key, this.messId});

  @override
  State<PlansScreen> createState() => _PlansScreenState();
}

class _PlansScreenState extends State<PlansScreen> {
  late PlansController controller;

  @override
  void initState() {
    super.initState();

    controller = Get.put(PlansController());

    if (widget.messId != null) {
      controller.fetchMessPlan(widget.messId!);   // ✅ FIXED
    }
  }

  @override
  void didUpdateWidget(covariant PlansScreen oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.messId != widget.messId && widget.messId != null) {
      controller.fetchMessPlan(widget.messId!);   // ✅ FIXED
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.messId == null) {
      return const Center(
        child: Text("Please select a mess", style: TextStyle(fontSize: 16)),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xffF5F6FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text("Plans", style: TextStyle(color: Colors.black)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: ElevatedButton.icon(
              icon: const Icon(Icons.add, size: 18),
              label: const Text("Add"),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff2F6FED),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => AddPlanScreen(messId: widget.messId!),
                  ),
                );
              },
            ),
          )
        ],
      ),

      body: GetBuilder<PlansController>(
        builder: (c) {
          if (c.isMessPlanLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (c.messPlanList.isEmpty) {
            return const Center(child: Text("No plans found"));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: c.messPlanList.length,
            itemBuilder: (context, index) {
              return PlanCard(plan: c.messPlanList[index]);
            },
          );
        },
      ),
    );
  }
}

class PlanCard extends StatelessWidget {
  final MessPlanModel plan;

  const PlanCard({super.key, required this.plan});

  @override
  Widget build(BuildContext context) {
    final meals =
    List<String>.from(plan.variation?.map((e) => e.title) ?? []);

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            plan.planName ?? "",
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
          const SizedBox(height: 6),
          Text(plan.description ?? "",
              style: const TextStyle(color: Colors.grey)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 6,
            children: meals.map((e) => Chip(label: Text(e))).toList(),
          )
        ],
      ),
    );
  }
}