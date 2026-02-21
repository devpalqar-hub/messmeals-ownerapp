import 'package:flutter/material.dart';
import '../service/api_service.dart';

class AddPlanScreen extends StatefulWidget {
  final String? messId;

  const AddPlanScreen({super.key, this.messId});

  @override
  State<AddPlanScreen> createState() => _AddPlanScreenState();
}

class _AddPlanScreenState extends State<AddPlanScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController minPriceController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController imageController = TextEditingController();

  List<String> selectedVariations = [];

  void toggleVariation(String value) {
    setState(() {
      if (selectedVariations.contains(value)) {
        selectedVariations.remove(value);
      } else {
        selectedVariations.add(value);
      }
    });
  }

  /// ⭐ SAVE PLAN
  Future<void> savePlan() async {
    if (widget.messId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Mess not selected")),
      );
      return;
    }

    if (nameController.text.isEmpty || priceController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Name & Price required")),
      );
      return;
    }

    try {
      final body = {
        "mess_id": widget.messId,
        "plan_name": nameController.text,
        "price": priceController.text,
        "min_price": minPriceController.text,
        "description": descController.text,
        "image": imageController.text,
        "variation": selectedVariations.map((e) => {"title": e}).toList(),
      };

      await ApiService.authorizedPost("/plans", body);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Plan added successfully")),
      );

      Navigator.pop(context);
    } catch (e) {
      debugPrint("Add plan error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F6FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        title: const Text("Add Plan", style: TextStyle(color: Colors.black)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  _input("Plan Name *", nameController),
                  _input("Price *", priceController, number: true),
                  _input("Minimum Price", minPriceController, number: true),
                  _textarea("Description", descController),
                  _input("Image URL", imageController),

                  const SizedBox(height: 16),
                  const Text("Delivery Variations *",
                      style: TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 10),

                  _checkbox("Lunch"),
                  _checkbox("Dinner"),
                  _checkbox("Both"),
                ],
              ),
            ),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Cancel"),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: savePlan,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                    ),
                    child: const Text("Save"),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  /// ================= UI HELPERS =================

  Widget _input(String label, TextEditingController controller,
      {bool number = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label),
          const SizedBox(height: 6),
          TextField(
            controller: controller,
            keyboardType:
            number ? TextInputType.number : TextInputType.text,
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xffF2F3F7),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _textarea(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label),
          const SizedBox(height: 6),
          TextField(
            controller: controller,
            maxLines: 4,
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xffF2F3F7),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _checkbox(String text) {
    final bool isSelected = selectedVariations.contains(text);

    return Row(
      children: [
        Checkbox(
          value: isSelected,
          onChanged: (_) => toggleVariation(text),
        ),
        Text(text),
      ],
    );
  }
}
