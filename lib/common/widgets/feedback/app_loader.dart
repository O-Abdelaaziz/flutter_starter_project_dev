import 'package:flutter/material.dart';

import '../../../../core/extensions/extensions.dart';

/// Centered adaptive loading indicator wrapper.
class AppLoader extends StatelessWidget {
  final double size;
  final Color? color;

  const AppLoader({super.key, this.size = 36.0, this.color});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: size,
        height: size,
        child: CircularProgressIndicator.adaptive(
          valueColor: AlwaysStoppedAnimation<Color>(
            color ?? context.colorScheme.primary,
          ),
          strokeWidth: 3.0,
        ),
      ),
    );
  }
}
