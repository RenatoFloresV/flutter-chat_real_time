import 'package:flutter/material.dart';

class CustomSnackbar {
  static SnackBar create({
    required String message,
    Color backgroundColor = Colors.blue,
    IconData icon = Icons.check_circle,
  }) {
    return SnackBar(
      content: Row(
        children: [
          Icon(
            icon,
            color: Colors.white,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      backgroundColor: backgroundColor,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      duration: const Duration(seconds: 4),
    );
  }
}
