import 'package:flutter/material.dart';

class MessDetailsScreen extends StatelessWidget {
  final String messId;
  final String messName;

  const MessDetailsScreen({
    super.key,
    required this.messId,
    required this.messName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(messName),
      ),
      body: Center(
        child: Text(
          "Selected Mess ID:\n$messId",
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
