import 'package:flutter/material.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../../core/utils/helpers/debouncer_helper.dart';

/// Secondary outlined button for secondary/alternative user choices.
class SecondaryButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isDisabled;
  final Widget? leadingIcon;
  final Widget? trailingIcon;
  final double? width;
  final double height;
  final Color? borderColor;
  final Color? foregroundColor;
  final double borderRadius;

  const SecondaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.isDisabled = false,
    this.leadingIcon,
    this.trailingIcon,
    this.width,
    this.height = 48.0,
    this.borderColor,
    this.foregroundColor,
    this.borderRadius = 12.0,
  });

  @override
  State<SecondaryButton> createState() => _SecondaryButtonState();
}

class _SecondaryButtonState extends State<SecondaryButton> {
  late final ThrottlerHelper _throttler;

  @override
  void initState() {
    super.initState();
    _throttler = ThrottlerHelper(duration: const Duration(milliseconds: 600));
  }

  @override
  void dispose() {
    _throttler.dispose();
    super.dispose();
  }

  void _handleTap() {
    if (widget.onPressed == null || widget.isLoading || widget.isDisabled)
      return;
    _throttler.run(widget.onPressed!);
  }

  @override
  Widget build(BuildContext context) {
    final effectiveBorderColor =
        widget.borderColor ?? context.colorScheme.outline;
    final effectiveForegroundColor =
        widget.foregroundColor ?? context.colorScheme.primary;

    return SizedBox(
      width: widget.width ?? double.infinity,
      height: widget.height,
      child: OutlinedButton(
        onPressed: (widget.isDisabled || widget.onPressed == null)
            ? null
            : _handleTap,
        style: OutlinedButton.styleFrom(
          foregroundColor: effectiveForegroundColor,
          side: BorderSide(color: effectiveBorderColor, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius),
          ),
        ),
        child: widget.isLoading
            ? SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    effectiveForegroundColor,
                  ),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (widget.leadingIcon != null) ...[
                    widget.leadingIcon!,
                    8.boxWidth,
                  ],
                  Text(
                    widget.text,
                    style: context.textTheme.labelLarge?.copyWith(
                      color: effectiveForegroundColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (widget.trailingIcon != null) ...[
                    8.boxWidth,
                    widget.trailingIcon!,
                  ],
                ],
              ),
      ),
    );
  }
}
