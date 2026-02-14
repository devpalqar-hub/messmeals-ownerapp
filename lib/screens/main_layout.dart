import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'customers_screen.dart';
import 'partners_screen.dart';
import 'deliveries_screen.dart';
import 'plans_screen.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {

  int selectedIndex = 0;

  final List<Widget> screens = [
    HomeScreen(),
    CustomersScreen(),
    PartnersScreen(),
    DeliveriesScreen(),
    PlansScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F6FA),


      body: screens[selectedIndex],

      bottomNavigationBar: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          padding: const EdgeInsets.symmetric(vertical: 10),

          decoration: BoxDecoration(
            color: const Color(0xff121826),
            borderRadius: BorderRadius.circular(22),
          ),

          child: Row(
            children: [
              _navItem(Icons.home_outlined, "Home", 0),
              _navItem(Icons.group_outlined, "Customers", 1),
              _navItem(Icons.pedal_bike_outlined, "Partners", 2),
              _navItem(Icons.local_shipping_outlined, "Deliveries", 3),
              _navItem(Icons.inventory_2_outlined, "Plans", 4),
            ],
          ),
        ),
      ),
    );
  }

  Widget _navItem(IconData icon, String label, int index) {
    final bool isSelected = selectedIndex == index;

    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () {
          setState(() {
            selectedIndex = index;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 8),

          decoration: BoxDecoration(
            color: isSelected ? const Color(0xff2F6FED) : Colors.transparent,
            borderRadius: BorderRadius.circular(14),
          ),

          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 20,
                color: isSelected ? Colors.white : Colors.grey,
              ),
              const SizedBox(height: 2),
              Text(
                label,
                style: TextStyle(
                  fontSize: 10,
                  color: isSelected ? Colors.white : Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
