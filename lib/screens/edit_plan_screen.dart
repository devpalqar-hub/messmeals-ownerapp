import 'package:flutter/material.dart';

class EditPlanScreen extends StatefulWidget {
  final Map<String, dynamic>? plan;

  const EditPlanScreen({super.key, this.plan});

  @override
  State<EditPlanScreen> createState() => _EditPlanScreenState();
}

class _EditPlanScreenState extends State<EditPlanScreen> {
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final minPriceController = TextEditingController();
  final descController = TextEditingController();
  final imageController = TextEditingController();

  bool lunch = false;
  bool dinner = false;
  bool both = false;

  @override
  void initState() {
    super.initState();

    final p = widget.plan;

    if (p != null) {
      nameController.text     = p["title"] ?? "";
      priceController.text    = p["price"] ?? "";
      minPriceController.text = p["minPrice"] ?? "";
      descController.text     = p["desc"] ?? "";

      final meals = List<String>.from(p["meals"] ?? []);

      lunch  = meals.contains("Lunch");
      dinner = meals.contains("Dinner");
      both   = meals.length == 2;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F6FA),

      /// APPBAR
      appBar: AppBar(
        title: const Text("Edit Plan"),
      ),

      /// BODY
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            _field("Plan Name *", nameController),
            _field("Price *", priceController),
            _field("Minimum Price", minPriceController),

            const SizedBox(height: 12),

            TextField(
              controller: descController,
              maxLines: 3,
              decoration: _decoration("Description"),
            ),

            const SizedBox(height: 12),

            _field("Image URL", imageController),

            const SizedBox(height: 16),

            const Align(
              alignment: Alignment.centerLeft,
              child: Text("Delivery Variations *"),
            ),

            CheckboxListTile(
              title: const Text("Lunch"),
              value: lunch,
              onChanged: (v) => setState(() => lunch = v!),
            ),
            CheckboxListTile(
              title: const Text("Dinner"),
              value: dinner,
              onChanged: (v) => setState(() => dinner = v!),
            ),
            CheckboxListTile(
              title: const Text("Both"),
              value: both,
              onChanged: (v) => setState(() => both = v!),
            ),

            const SizedBox(height: 20),

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
                    onPressed: () {
                      Navigator.pop(context);
                    },
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

  Widget _field(String label, TextEditingController c) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: c,
        decoration: _decoration(label),
      ),
    );
  }

  InputDecoration _decoration(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}