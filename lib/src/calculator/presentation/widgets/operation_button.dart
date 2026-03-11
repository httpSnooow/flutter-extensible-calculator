import 'package:flutter/material.dart';

class OperationButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? color;

  const OperationButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color ?? Colors.grey[200],
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          textStyle: const TextStyle(fontSize: 16),
          padding: EdgeInsets.zero,
        ),
        onPressed: onPressed,
        child: Text(text),
      ),
    );
  }
}
