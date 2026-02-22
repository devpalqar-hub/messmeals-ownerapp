import 'package:flutter/material.dart';

class DeliveriesScreen extends StatelessWidget {
  final String? messId;
  const DeliveriesScreen({super.key, this.messId});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// HEADER
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Deliveries",
                      style:
                      TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  SizedBox(height: 4),
                  Text("3 total deliveries",
                      style: TextStyle(color: Colors.grey)),
                ],
              ),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff3B6EA5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {},
                icon: const Icon(Icons.add),
                label: const Text("Generate"),
              )
            ],
          ),

          const SizedBox(height: 14),

          /// FILTERS
          Row(
            children: [
              Expanded(child: _filterBox("All Status")),
              const SizedBox(width: 10),
              Expanded(child: _filterBox("All Dates")),
            ],
          ),

          const SizedBox(height: 14),

          /// DELIVERY LIST
          const DeliveryCard(),
          const DeliveryCard(inProgress: true),
          const DeliveryCard(),
        ],
      ),
    );
  }

  Widget _filterBox(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xffF1F3F6),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text),
          const Icon(Icons.keyboard_arrow_down),
        ],
      ),
    );
  }
}
class DeliveryCard extends StatelessWidget {
  final bool inProgress;

  const DeliveryCard({super.key, this.inProgress = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// STATUS + PRICE
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  inProgress ? "in-progress" : "completed",
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: const [
                  Text("₹100",
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                  Text("16/10/2025", style: TextStyle(color: Colors.grey)),
                ],
              )
            ],
          ),

          const SizedBox(height: 6),

          const Text("Rahul Sharma",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 4),
          const Text("+919497677913", style: TextStyle(color: Colors.grey)),

          const SizedBox(height: 8),
          const Divider(),

          /// SEGMENT BUTTON
          Container(
            decoration: BoxDecoration(
              color: const Color(0xffF1F3F6),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: const [
                _SegmentBtn("Pending", false),
                _SegmentBtn("Progress", true),
                _SegmentBtn("Done", false),
              ],
            ),
          )
        ],
      ),
    );
  }
}
class _SegmentBtn extends StatelessWidget {
  final String text;
  final bool selected;

  const _SegmentBtn(this.text, this.selected);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: selected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(child: Text(text)),
      ),
    );
  }
}