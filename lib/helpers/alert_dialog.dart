import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

viewAlert(BuildContext context, String title, String message, AlertType type) {
  final iconMap = {
    AlertType.success:
        const Icon(Icons.check_circle_outline, color: Colors.green, size: 50),
    AlertType.error:
        const Icon(Icons.error_outline, color: Colors.red, size: 50),
    AlertType.warning: const Icon(Icons.warning_amber_outlined,
        color: Colors.yellow, size: 50),
    AlertType.info:
        const Icon(Icons.info_outline, color: Colors.blue, size: 50),
  };

  List<Widget> actions = [
    if (Platform.isAndroid)
      TextButton(
        child: const Text('Ok'),
        onPressed: () => Navigator.of(context).pop(),
      )
    else
      CupertinoDialogAction(
        child: const Text('Ok'),
        onPressed: () => Navigator.of(context).pop(),
      )
  ];

  Widget dialogContent = Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const SizedBox(height: 10),
      iconMap[type]!,
      const SizedBox(height: 10),
      Text(message),
    ],
  );

  if (Platform.isAndroid) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: dialogContent,
          elevation: 5,
          actions: actions,
        );
      },
    );
  } else {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text(title),
          content: dialogContent,
          actions: actions,
        );
      },
    );
  }
}

enum AlertType { success, error, warning, info }
