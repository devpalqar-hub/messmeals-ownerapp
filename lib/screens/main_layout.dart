import 'package:flutter/material.dart';
import '../service/api_service.dart';

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

  List<dynamic> messList = [];
  int? selectedMessId;
  bool isLoadingMess = true;

  @override
  void initState() {
    super.initState();
    fetchMesses();
  }

  /// ================= FETCH MESSES =================
  Future<void> fetchMesses() async {
    try {
      final data = await ApiService.getAllMesses(); // ✅ already List

      setState(() {
        messList = data;
        isLoadingMess = false;
      });

    } catch (e) {
      setState(() {
        isLoadingMess = false;
      });
      debugPrint("Mess Load Error: $e");
    }
  }

  /// ================= SCREENS =================
  List<Widget> get screens => [
    HomeScreen(messId: selectedMessId),
    CustomersScreen(messId: selectedMessId),
    PartnersScreen(messId: selectedMessId),
    DeliveriesScreen(messId: selectedMessId),
    PlansScreen(messId: selectedMessId),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F6FA),

      /// ================= APP BAR =================
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        title: const Text(
          "SuperMeals Admin",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: isLoadingMess
                ? const SizedBox(
              width: 24,
              height: 24,
              child: Padding(
                padding: EdgeInsets.all(4.0),
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            )
                : DropdownButtonHideUnderline(
              child: DropdownButton<int>(
                hint: const Text(
                  "Select Mess",
                  style: TextStyle(color: Colors.black),
                ),
                value: selectedMessId,
                icon: const Icon(Icons.arrow_drop_down,
                    color: Colors.black),

                /// ✅ SAFE INT CONVERSION
                items: messList.map<DropdownMenuItem<int>>((mess) {
                  final id = (mess["id"] as num?)?.toInt();

                  return DropdownMenuItem<int>(
                    value: id,
                    child: Text(
                      mess["name"]?.toString() ?? "Mess",
                    ),
                  );
                }).toList(),

                onChanged: (value) {
                  setState(() {
                    selectedMessId = value;
                    selectedIndex = 0; // Reset to Home
                  });

                  debugPrint("Selected Mess ID: $value");
                },
              ),
            ),
          )
        ],
      ),

      /// ================= BODY =================
      body: screens[selectedIndex],

      /// ================= BOTTOM NAV =================
      bottomNavigationBar: SafeArea(
        child: Container(
          margin:
          const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
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
            color:
            isSelected ? const Color(0xff2F6FED) : Colors.transparent,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
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
