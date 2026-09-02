import 'package:flutter/material.dart';

import '../../../../core/extensions/extensions.dart';

/// Modal dialog that blocks user interaction during long-running async calls.
class LoadingDialog extends StatelessWidget {
  final String message;

  const LoadingDialog({super.key, this.message = 'Please wait...'});

  static void show(BuildContext context, {String message = 'Please wait...'}) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (_) => LoadingDialog(message: message),
    );
  }

  static void hide(BuildContext context) {
    if (Navigator.canPop(context)) {
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 32.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(),
              16.boxHeight,
              Text(
                message,
                style: context.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
