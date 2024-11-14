import 'package:flutter/material.dart';

class ConfirmationDialog extends StatelessWidget {
  final String message;
  final VoidCallback onYesPressed;
  const ConfirmationDialog({
    required this.message,
    required this.onYesPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Confirmation'),
      content: Text('Are you sure you want to $message'),
      actions: [
        TextButton(
          onPressed: onYesPressed,
          child: const Text('Yes'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('No'),
        ),
      ],
    );
  }
}
