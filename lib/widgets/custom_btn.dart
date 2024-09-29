import 'package:flutter/material.dart';

class CustomBtn extends StatelessWidget {
  const CustomBtn({
    super.key,
    required this.text,
    required this.onLoginPressed,
  });

  final String text;
  final VoidCallback onLoginPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onLoginPressed,
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
