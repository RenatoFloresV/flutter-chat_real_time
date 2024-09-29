import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({this.text = 'Chat App', super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      margin: const EdgeInsets.only(top: 30),
      child: Column(
        children: [
          const Image(image: AssetImage('assets/logo.png')),
          const SizedBox(height: 20),
          Text(text,
              style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87)),
        ],
      ),
    ));
  }
}
