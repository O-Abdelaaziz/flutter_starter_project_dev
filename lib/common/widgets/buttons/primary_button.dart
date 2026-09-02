import 'package:flutter/material.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../../core/utils/helpers/debouncer_helper.dart';

/// Primary filled button for principal actions throughout the app.
class PrimaryButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isDisabled;
  final Widget? leadingIcon;
  final Widget? trailingIcon;
  final double? width;
  final double height;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double borderRadius;

  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.isDisabled = false,
    this.leadingIcon,
    this.trailingIcon,
    this.width,
    this.height = 48.0,
    this.backgroundColor,
    this.foregroundColor,
    this.borderRadius = 12.0,
  });

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
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
    final effectiveBackgroundColor =
        widget.backgroundColor ?? context.colorScheme.primary;
    final effectiveForegroundColor =
        widget.foregroundColor ?? context.colorScheme.onPrimary;

    return SizedBox(
      width: widget.width ?? double.infinity,
      height: widget.height,
      child: ElevatedButton(
        onPressed: (widget.isDisabled || widget.onPressed == null)
            ? null
            : _handleTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: effectiveBackgroundColor,
          foregroundColor: effectiveForegroundColor,
          disabledBackgroundColor: context.colorScheme.onSurface.withValues(
            alpha: 0.12,
          ),
          disabledForegroundColor: context.colorScheme.onSurface.withValues(
            alpha: 0.38,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius),
          ),
          elevation: 0,
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
