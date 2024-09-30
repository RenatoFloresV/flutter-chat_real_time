import 'package:flutter/material.dart';

class LabelsLogin extends StatelessWidget {
  const LabelsLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('No account yet?',
            style: TextStyle(fontSize: 15, color: Colors.black54)),
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, 'register'),
          child: Text('Register here !!!',
              style: TextStyle(fontSize: 18, color: Colors.blue[600])),
        ),
      ],
    );
  }
}
