import 'package:flutter/material.dart';

class ConfirmDialog extends StatelessWidget {
  final String textContent;
  final Function onTabOK;
  const ConfirmDialog(this.textContent, {required this.onTabOK, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Confirmación'),
      content: Text(textContent),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context, 'NO'), child: const Text('NO')),
        TextButton(
            onPressed: () {
              Navigator.pop(context, 'SI');
              onTabOK();
            },
            child: const Text('SI')),
      ],
    );
  }
}
