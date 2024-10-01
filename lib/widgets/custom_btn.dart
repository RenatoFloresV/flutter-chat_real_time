import 'package:flutter/material.dart';

class CustomBtn extends StatelessWidget {
  const CustomBtn({
    super.key,
    required this.text,
    required this.onPressed,
  });

  final String text;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
        elevation: 2,
        padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
      ),
      child: SizedBox(
          width: double.infinity,
          child:
              Center(child: Text(text, style: const TextStyle(fontSize: 20)))),
    );
  }
}
