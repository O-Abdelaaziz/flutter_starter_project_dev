import 'package:flutter/material.dart';

import '../../../../core/extensions/extensions.dart';
import '../buttons/primary_button.dart';

/// Standard alert dialog wrapper for general system messages and notifications.
class AppDialog extends StatelessWidget {
  final String title;
  final String message;
  final String? buttonText;
  final VoidCallback? onConfirm;
  final Widget? icon;

  const AppDialog({
    super.key,
    required this.title,
    required this.message,
    this.buttonText,
    this.onConfirm,
    this.icon,
  });

  static Future<void> show(
    BuildContext context, {
    required String title,
    required String message,
    String? buttonText,
    VoidCallback? onConfirm,
    Widget? icon,
  }) {
    return showDialog<void>(
      context: context,
      builder: (ctx) => AppDialog(
        title: title,
        message: message,
        buttonText: buttonText,
        onConfirm: onConfirm,
        icon: icon,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: icon,
      title: Text(
        title,
        textAlign: TextAlign.center,
        style: context.textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Text(
        message,
        textAlign: TextAlign.center,
        style: context.textTheme.bodyMedium,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        PrimaryButton(
          text: buttonText ?? 'OK',
          height: 44.0,
          onPressed: () {
            context.pop();
            if (onConfirm != null) onConfirm!();
          },
        ),
      ],
    );
  }
}
