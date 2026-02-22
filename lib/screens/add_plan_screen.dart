import 'package:flutter/material.dart';

class AddPlanSheet extends StatefulWidget {
  const AddPlanSheet({super.key});

  @override
  State<AddPlanSheet> createState() => _AddPlanSheetState();
}

class _AddPlanSheetState extends State<AddPlanSheet> {
  final name = TextEditingController();
  final price = TextEditingController(text: "0");
  final minPrice = TextEditingController(text: "0");
  final desc = TextEditingController();
  final image = TextEditingController(text: "https://example.com/image.jpg");

  bool lunch = false;
  bool dinner = false;
  bool both = false;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.8,
      maxChildSize: 0.95,
      minChildSize: 0.6,
      builder: (_, controller) {
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: ListView(
            controller: controller,
            children: [
              /// DRAG HANDLE
              Center(
                child: Container(
                  width: 40,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              _label("Plan Name *"),
              _field(name),

              const SizedBox(height: 10),

              _label("Price *"),
              _field(price),

              const SizedBox(height: 10),

              _label("Minimum Price"),
              _field(minPrice),

              const SizedBox(height: 10),

              _label("Description"),
              _field(desc, max: 3),

              const SizedBox(height: 10),

              _label("Image URL"),
              _field(image),

              const SizedBox(height: 12),

              _label("Delivery Variations *"),

              CheckboxListTile(
                value: lunch,
                onChanged: (v) => setState(() => lunch = v!),
                title: const Text("Lunch"),
                controlAffinity: ListTileControlAffinity.leading,
              ),
              CheckboxListTile(
                value: dinner,
                onChanged: (v) => setState(() => dinner = v!),
                title: const Text("Dinner"),
                controlAffinity: ListTileControlAffinity.leading,
              ),
              CheckboxListTile(
                value: both,
                onChanged: (v) => setState(() => both = v!),
                title: const Text("Both"),
                controlAffinity: ListTileControlAffinity.leading,
              ),

              const SizedBox(height: 10),

              /// BUTTONS
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text("Cancel"),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: () {},
                      child: const Text("Save"),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  /// LABEL
  Widget _label(String text) {
    return Text(text, style: const TextStyle(fontWeight: FontWeight.w500));
  }

  /// FIELD
  Widget _field(TextEditingController c, {int max = 1}) {
    return TextField(
      controller: c,
      maxLines: max,
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xffF1F3F6),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}