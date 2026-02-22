import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../service/api_service.dart';

class HomeScreen extends StatefulWidget {
  final String? messId;
  const HomeScreen({super.key, this.messId});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<String, dynamic>? stats;
  bool isLoading = true;
  Future<void> fetchDashboard() async {
    if (widget.messId == null) return;

    try {
      final data = await ApiService.getDashboard(widget.messId!);

      setState(() {
        stats = data;
        isLoading = false;
      });
    } catch (e) {
      debugPrint("Dashboard error: $e");
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// DASHBOARD TITLE
          const Text(
            "Dashboard",
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 16),

          /// REVENUE CARD
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xff5C9FA4),
              borderRadius: BorderRadius.circular(24),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Total Revenue",
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
                SizedBox(height: 6),
                Text(
                  "₹2800.00",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          /// GRID STATS
          GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 14,
            mainAxisSpacing: 14,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            childAspectRatio: 1.2,
            children: const [
              _DashboardCard(Icons.shopping_bag_outlined, "Total Orders", "1"),
              _DashboardCard(Icons.group_outlined, "Customers", "1"),
              _DashboardCard(Icons.pedal_bike_outlined, "Partners", "2"),
              _DashboardCard(Icons.currency_rupee, "Avg/Customer", "₹2800.00"),
            ],
          ),

          const SizedBox(height: 14),

          /// REVENUE ROW
          Row(
            children: const [
              Expanded(
                child: _RevenueCard(
                  "Pending Revenue",
                  "₹0.00",
                  Color(0xffE8D1B1),
                ),
              ),
              SizedBox(width: 14),
              Expanded(
                child: _RevenueCard(
                  "Total Revenue",
                  "₹2800.00",
                  Color(0xffBFD7C5),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          /// MEAL BREAKDOWN CARD
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Meal Type Breakdown",
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xffF1F3F6),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text("Feb 12, 2026"),
                    )
                  ],
                ),
                const SizedBox(height: 20),

                SizedBox(
                  height: 180,
                  child: PieChart(
                    PieChartData(
                      centerSpaceRadius: 50,
                      sectionsSpace: 2,
                      sections: [
                        PieChartSectionData(
                          value: 60,
                          color: const Color(0xff1CA7B8),
                          radius: 24,
                          showTitle: false,
                        ),
                        PieChartSectionData(
                          value: 40,
                          color: const Color(0xff128F7E),
                          radius: 24,
                          showTitle: false,
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _LegendDot(Color(0xff1CA7B8), "Breakfast"),
                    SizedBox(width: 16),
                    _LegendDot(Color(0xff128F7E), "Lunch"),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}
class _DashboardCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _DashboardCard(this.icon, this.title, this.value);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.grey),
          const Spacer(),
          Text(title, style: const TextStyle(color: Colors.grey)),
          const SizedBox(height: 4),
          Text(value,
              style:
              const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
class _RevenueCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;

  const _RevenueCard(this.title, this.value, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration:
      BoxDecoration(color: color, borderRadius: BorderRadius.circular(24)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title),
          const SizedBox(height: 6),
          Text(value,
              style:
              const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        ],
      ),
    );
  }
}
class _LegendDot extends StatelessWidget {
  final Color color;
  final String text;

  const _LegendDot(this.color, this.text);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(radius: 5, backgroundColor: color),
        const SizedBox(width: 6),
        Text(text),
      ],
    );
  }
}
