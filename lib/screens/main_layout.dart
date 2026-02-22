import 'package:flutter/material.dart';
import '../service/api_service.dart';
import 'home_screen.dart';
import 'plans_screen.dart';
import 'customers_screen.dart';
import 'partners_screen.dart';
import 'deliveries_screen.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int selectedIndex = 0;

  List<dynamic> messes = [];
  String? selectedMessId;
  bool isLoadingMess = true;

  @override
  void initState() {
    super.initState();
    fetchMesses();
  }

  Future<void> fetchMesses() async {
    try {
      final data = await ApiService.getOwnerMesses();

      setState(() {
        messes = [data];

        if (messes.isNotEmpty) {
          selectedMessId = messes.first["_id"].toString();
        }

        isLoadingMess = false;
      });
    } catch (e) {
      debugPrint("Mess fetch error: $e");
      setState(() => isLoadingMess = false);
    }
  }

  /// ⭐ SCREENS
  List<Widget> get screens => [
    HomeScreen(messId: selectedMessId),
    PlansScreen(messId: selectedMessId),
    CustomersScreen(messId: selectedMessId),
    PartnersScreen(messId: selectedMessId),
    DeliveriesScreen(messId: selectedMessId),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F6FA),

      /// ⭐ APP BAR
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: isLoadingMess
            ? const SizedBox(
          height: 20,
          width: 20,
          child: CircularProgressIndicator(strokeWidth: 2),
        )
            : messes.isEmpty
            ? const Text("No Mess")
            : DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: selectedMessId,
            hint: const Text("Select Mess"),
            items: messes.map((mess) {
              return DropdownMenuItem<String>(
                value: mess["_id"].toString(),
                child: Text(mess["name"] ?? ""),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                selectedMessId = value;
                selectedIndex = 0;
              });
            },
          ),
        ),
      ),

      /// ⭐ BODY
      body: screens[selectedIndex],

      /// ⭐ BOTTOM NAV
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        selectedItemColor: const Color(0xff5B9EA3),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: (index) => setState(() => selectedIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: "Plans"),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: "Customers"),
          BottomNavigationBarItem(
              icon: Icon(Icons.delivery_dining), label: "Partners"),
          BottomNavigationBarItem(
              icon: Icon(Icons.local_shipping), label: "Delivery"),
        ],
      ),
    );
  }
}