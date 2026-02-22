import 'package:flutter/material.dart';

class PlansScreen extends StatelessWidget {
  const PlansScreen({super.key, String? messId});

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
              /// HEADER
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Plans",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "4 Plans added",
                        style: TextStyle(color: Colors.grey),
                      ),
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

              const SizedBox(height: 16),

              /// SEARCH
              TextField(
                decoration: InputDecoration(
                  hintText: "Search customers...",
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(vertical: 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 16),

              /// PLAN LIST
              Expanded(
                child: ListView(
                  children: const [
                    PlanCard(
                      title: "Basic Plan",
                      price: "₹3000",
                      minPrice: "₹2500",
                      desc: "Standard meals with basic menu",
                      meals: ["Lunch", "Dinner"],
                    ),
                    PlanCard(
                      title: "Premium Plan",
                      price: "₹5000",
                      minPrice: "₹4500",
                      desc: "Premium meals with extended",
                      meals: ["Breakfast", "Lunch", "Dinner"],
                    ),
                    PlanCard(
                      title: "Lunch Only",
                      price: "₹2000",
                      minPrice: "",
                      desc: "Lunch meals only",
                      meals: ["Lunch"],
                    ),
                    PlanCard(
                      title: "Breakfast Special",
                      price: "₹1500",
                      minPrice: "",
                      desc: "Breakfast meals",
                      meals: ["Breakfast"],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class PlanCard extends StatelessWidget {
  final String title;
  final String price;
  final String minPrice;
  final String desc;
  final List<String> meals;

  const PlanCard({
    super.key,
    required this.title,
    required this.price,
    required this.minPrice,
    required this.desc,
    required this.meals,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          /// ICON
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xffEEF1F5),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.restaurant),
          ),

          const SizedBox(width: 12),

          /// DETAILS
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// TITLE + PRICE
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(title,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    Text(price,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15)),
                  ],
                ),

                if (minPrice.isNotEmpty)
                  Text("Min: $minPrice",
                      style: const TextStyle(color: Colors.grey)),

                const SizedBox(height: 4),
                Text(desc, style: const TextStyle(color: Colors.grey)),

                const SizedBox(height: 8),

                /// MEAL TAGS
                Wrap(
                  spacing: 6,
                  children: meals
                      .map(
                        (e) => Chip(
                      label: Text(e),
                      backgroundColor: const Color(0xffEEF1F5),
                    ),
                  )
                      .toList(),
                )
              ],
            ),
          ),

          /// ACTIONS
          Column(
            children: const [
              Icon(Icons.edit, size: 20),
              SizedBox(height: 10),
              Icon(Icons.delete, size: 20),
            ],
          )
        ],
      ),
    );
  }
}