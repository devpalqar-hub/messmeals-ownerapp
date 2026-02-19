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

  @override
  void initState() {
    super.initState();
    fetchDashboard();
  }

  @override
  void didUpdateWidget(covariant HomeScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.messId != widget.messId) {
      setState(() => isLoading = true);
      fetchDashboard();
    }
  }

  Future<void> fetchDashboard() async {
    try {
      final data = await ApiService.getDashboardStats(widget.messId);

      setState(() {
        stats = data["data"] ?? data;
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
      debugPrint("Dashboard Error: $e");
    }
  }

  double _toDouble(dynamic value) {
    if (value == null) return 0;
    if (value is num) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0;
    return 0;
  }

  int _toInt(dynamic value) {
    if (value == null) return 0;
    if (value is num) return value.toInt();
    if (value is String) return int.tryParse(value) ?? 0;
    return 0;
  }


  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (stats == null) {
      return const Center(child: Text("No Data Available"));
    }

    double totalRevenue = _toDouble(stats!["totalRevenue"]);
    int totalOrders = _toInt(stats!["totalOrders"]);
    int customers = _toInt(stats!["customers"]);
    int partners = _toInt(stats!["partners"]);
    double avgCustomer = _toDouble(stats!["avgPerCustomer"]);
    double pendingRevenue = _toDouble(stats!["pendingRevenue"]);
    double breakfast = _toDouble(stats!["breakfast"]);
    double lunch = _toDouble(stats!["lunch"]);




    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 110),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Dashboard",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 16),


          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xff5B9EA3),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Total Revenue",
                  style: TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 6),
                Text(
                  "₹${totalRevenue.toStringAsFixed(2)}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 14,
            crossAxisSpacing: 14,
            childAspectRatio: 1.15,
            children: [
              _StatCard(Icons.shopping_bag_outlined,
                  "Total Orders", "$totalOrders"),
              _StatCard(Icons.group_outlined,
                  "Customers", "$customers"),
              _StatCard(Icons.delivery_dining_outlined,
                  "Partners", "$partners"),
              _StatCard(Icons.currency_rupee,
                  "Avg/Customer", "₹${avgCustomer.toStringAsFixed(2)}"),
            ],
          ),

          const SizedBox(height: 18),

          Row(
            children: [
              Expanded(
                child: _SmallRevenueCard(
                  "Pending Revenue",
                  "₹${pendingRevenue.toStringAsFixed(2)}",
                  const Color(0xffF3D9B8),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _SmallRevenueCard(
                  "Total Revenue",
                  "₹${totalRevenue.toStringAsFixed(2)}",
                  const Color(0xffCDE7D4),
                ),
              ),
            ],
          ),

          const SizedBox(height: 22),

          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Meal Type Breakdown",
                        style: TextStyle(fontWeight: FontWeight.w600)),
                    Text("Today")
                  ],
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 160,
                  child: PieChart(
                    PieChartData(
                      sectionsSpace: 3,
                      centerSpaceRadius: 50,
                      sections: [
                        PieChartSectionData(
                          value: breakfast == 0 ? 1 : breakfast,
                          color: Colors.cyan,
                          showTitle: false,
                        ),
                        PieChartSectionData(
                          value: lunch == 0 ? 1 : lunch,
                          color: Colors.teal,
                          showTitle: false,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
class _StatCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _StatCard(this.icon, this.title, this.value);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 22, color: Colors.black54),
          const Spacer(),
          Text(title, style: const TextStyle(color: Colors.grey)),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}

class _SmallRevenueCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;

  const _SmallRevenueCard(this.title, this.value, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
