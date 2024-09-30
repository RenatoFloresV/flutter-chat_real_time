import 'package:flutter/material.dart';

class LabelsRegister extends StatelessWidget {
  const LabelsRegister({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('I already have an account',
            style: TextStyle(fontSize: 15, color: Colors.black54)),
        GestureDetector(
          onTap: () => Navigator.pushReplacementNamed(context, 'login'),
          child: Text('Login here !!!',
              style: TextStyle(fontSize: 18, color: Colors.blue[600])),
        ),
      ],
    );
  }
}
