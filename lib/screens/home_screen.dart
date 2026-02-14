import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xffF5F6FA),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(16, 16, 16, 110),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// TITLE
              Text(
                "Dashboard",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),

              SizedBox(height: 16),

              _RevenueHeaderCard(),

              SizedBox(height: 20),

              _StatsGrid(),

              SizedBox(height: 18),

              _RevenueBoxes(),

              SizedBox(height: 22),

              _MealBreakdownCard(),
            ],
          ),
        ),
      ),
    );
  }
}



/// ================= BIG GREEN REVENUE CARD =================
class _RevenueHeaderCard extends StatelessWidget {
  const _RevenueHeaderCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xff5B9EA3),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Total Revenue",
              style: TextStyle(color: Colors.white70, fontSize: 14)),
          SizedBox(height: 6),
          Text("₹2800.00",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

/// ================= EXACT WHITE CARDS GRID =================
class _StatsGrid extends StatelessWidget {
  const _StatsGrid();

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 14,
      crossAxisSpacing: 14,
      childAspectRatio: 1.15,
      children: const [
        _StatCard(Icons.shopping_bag_outlined, "Total Orders", "1"),
        _StatCard(Icons.group_outlined, "Customers", "1"),
        _StatCard(Icons.delivery_dining_outlined, "Partners", "2"),
        _StatCard(Icons.currency_rupee, "Avg/Customer", "₹2800.00"),
      ],
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

/// ================= BOTTOM SMALL REVENUE BOXES =================
class _RevenueBoxes extends StatelessWidget {
  const _RevenueBoxes();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          child: _SmallRevenueCard(
            "Pending Revenue",
            "₹0.00",
            Color(0xffF3D9B8),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: _SmallRevenueCard(
            "Total Revenue",
            "₹2800.00",
            Color(0xffCDE7D4),
          ),
        ),
      ],
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
      decoration:
      BoxDecoration(color: color, borderRadius: BorderRadius.circular(18)),
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

/// ================= pie chart=================
class _MealBreakdownCard extends StatelessWidget {
  const _MealBreakdownCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [

          /// header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Meal Type Breakdown",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text("Feb 12, 2026"),
              )
            ],
          ),

          const SizedBox(height: 20),

          /// donut
          SizedBox(
            height: 160,
            child: PieChart(
              PieChartData(
                sectionsSpace: 3,
                centerSpaceRadius: 50,
                sections: [
                  PieChartSectionData(
                      value: 65, color: Colors.cyan, showTitle: false),
                  PieChartSectionData(
                      value: 35, color: Colors.teal, showTitle: false),
                ],
              ),
            ),
          ),

          const SizedBox(height: 10),

          /// legend
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _LegendDot(Colors.cyan, "Breakfast"),
              SizedBox(width: 20),
              _LegendDot(Colors.teal, "Lunch"),
            ],
          )
        ],
      ),
    );
  }
}

class _LegendDot extends StatelessWidget {
  final Color color;
  final String label;

  const _LegendDot(this.color, this.label);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration:
          BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(label),
      ],
    );
  }
}