import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/utils.dart';
import 'package:messmeals/controllers/plansController.dart';
import 'package:messmeals/models/mess_plan_model.dart';
import 'add_plan_screen.dart';
import 'edit_plan_screen.dart';

class PlansScreen extends StatelessWidget {
  PlansScreen({super.key});

  /// ------------------ DATA ------------------
  final List<Map<String, dynamic>> plans = [
    {
      "title": "Basic Plan",
      "price": "₹3000",
      "minPrice": "₹2500",
      "desc": "Standard meals with basic menu",
      "meals": ["Lunch", "Dinner"]
    },
    {
      "title": "Premium Plan",
      "price": "₹5000",
      "minPrice": "₹4500",
      "desc": "Premium meals with extended",
      "meals": ["Breakfast", "Lunch", "Dinner"]
    },
  ];

  Planscontroller controller = Get.put(Planscontroller());
  @override
  Widget build(BuildContext context) {
    controller.fetchMessPlan();
    return Scaffold(
      backgroundColor: const Color(0xffF5F6FA),

      /// ================ APPBAR =================
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Plans",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
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
                    builder: (_) => const AddPlanScreen(),
                  ),
                );
              },
            ),
          )
        ],
      ),

      /// ================= BODY =================
      body: SafeArea(
        child: GetBuilder<Planscontroller>(builder: (__) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: (__.isMessPlanLoading)
                ? Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        /// 🔍 SEARCH
                        TextField(
                          decoration: InputDecoration(
                            hintText: "Search plans...",
                            prefixIcon: const Icon(Icons.search),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),
                        for (var data in __.messPlanList) PlanCard(plan: data)

                        /// 📋 LIST
                      ],
                    ),
                  ),
          );
        }),
      ),
    );
  }
}

class PlanCard extends StatelessWidget {
  MessPlanModel plan;

  PlanCard({super.key, required this.plan});

  @override
  Widget build(BuildContext context) {
    final meals =
        List<String>.from(plan.variation!.map((ctx) => ctx.title)).toList();

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
          /// TITLE + PRICE
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                plan.planName ?? "",
                style:
                    const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(plan.price ?? ""),
                  if ((plan.minPrice ?? "").toString().isNotEmpty)
                    Text(
                      "Min: ${plan.minPrice}",
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                ],
              )
            ],
          ),

          const SizedBox(height: 8),

          /// DESCRIPTION
          Text(plan.description ?? "",
              style: const TextStyle(color: Colors.grey)),

          const SizedBox(height: 10),

          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /// MEAL TAGS (LEFT SIDE)
              Expanded(
                child: Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: meals
                      .map(
                        (e) => Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: const Color(0xffF1F2F6),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            e,
                            style: const TextStyle(fontSize: 12),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),

              /// EDIT + DELETE (RIGHT SIDE)
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, size: 20),
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (_) => EditPlanScreen(plan: plan),
                      //   ),
                      // );
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, size: 20),
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
