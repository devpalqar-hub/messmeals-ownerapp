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
      fetchDashboard();
    }
  }

  Future<void> fetchDashboard() async {
    if (widget.messId == null) return;

    try {
      setState(() => isLoading = true);

      /// ✅ FIX: messId!
      final data = await ApiService.getDashboardStats(widget.messId!);

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
    if (widget.messId == null) {
      return const Center(child: Text("Select a mess"));
    }

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
          const Text("Dashboard",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
          const SizedBox(height: 16),

          /// ⭐ Revenue Card
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
                const Text("Total Revenue",
                    style: TextStyle(color: Colors.white70)),
                const SizedBox(height: 6),
                Text("₹${totalRevenue.toStringAsFixed(2)}",
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold)),
              ],
            ),
          ),

          const SizedBox(height: 20),

          /// ⭐ Stats Grid
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 14,
            crossAxisSpacing: 14,
            childAspectRatio: 1.15,
            children: [
              _StatCard(Icons.shopping_bag_outlined, "Total Orders", "$totalOrders"),
              _StatCard(Icons.group_outlined, "Customers", "$customers"),
              _StatCard(Icons.delivery_dining_outlined, "Partners", "$partners"),
              _StatCard(Icons.currency_rupee, "Avg/Customer",
                  "₹${avgCustomer.toStringAsFixed(2)}"),
            ],
          ),

          const SizedBox(height: 22),

          /// ⭐ Pie Chart
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
            ),
            child: SizedBox(
              height: 160,
              child: PieChart(
                PieChartData(
                  sectionsSpace: 3,
                  centerSpaceRadius: 50,
                  sections: [
                    PieChartSectionData(
                        value: breakfast == 0 ? 1 : breakfast,
                        color: Colors.cyan,
                        showTitle: false),
                    PieChartSectionData(
                        value: lunch == 0 ? 1 : lunch,
                        color: Colors.teal,
                        showTitle: false),
                  ],
                ),
              ),
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
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 22, color: Colors.black54),
          const Spacer(),
          Text(title, style: const TextStyle(color: Colors.grey)),
          const SizedBox(height: 4),
          Text(value,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        ],
      ),
    );
  }
}