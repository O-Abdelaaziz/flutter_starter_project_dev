import 'package:flutter/material.dart';

import '../../../../core/extensions/extensions.dart';
import '../buttons/primary_button.dart';
import '../buttons/secondary_button.dart';

/// Confirmation dialog for user prompts (e.g., deletion, logout, discard changes).
class ConfirmDialog extends StatelessWidget {
  final String title;
  final String message;
  final String confirmText;
  final String cancelText;
  final VoidCallback onConfirm;
  final bool isDestructive;

  const ConfirmDialog({
    super.key,
    required this.title,
    required this.message,
    this.confirmText = 'Confirm',
    this.cancelText = 'Cancel',
    required this.onConfirm,
    this.isDestructive = false,
  });

  static Future<bool> show(
    BuildContext context, {
    required String title,
    required String message,
    String confirmText = 'Confirm',
    String cancelText = 'Cancel',
    required VoidCallback onConfirm,
    bool isDestructive = false,
  }) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (ctx) => ConfirmDialog(
        title: title,
        message: message,
        confirmText: confirmText,
        cancelText: cancelText,
        onConfirm: onConfirm,
        isDestructive: isDestructive,
      ),
    );
    return result ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = isDestructive
        ? context.colorScheme.error
        : context.colorScheme.primary;

    return AlertDialog(
      title: Text(
        title,
        style: context.textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Text(message, style: context.textTheme.bodyMedium),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      actions: [
        Row(
          children: [
            Expanded(
              child: SecondaryButton(
                text: cancelText,
                height: 44.0,
                onPressed: () => context.pop(false),
              ),
            ),
            12.boxWidth,
            Expanded(
              child: PrimaryButton(
                text: confirmText,
                height: 44.0,
                backgroundColor: primaryColor,
                onPressed: () {
                  context.pop(true);
                  onConfirm();
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
