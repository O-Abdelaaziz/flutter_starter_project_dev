import 'package:flutter/material.dart';

/// Design Tokens: Border Radius
/// TRadius defines all corner radius tokens used across the app.
/// Organized by scale, semantic usage, and accessibility variants.
class TRadius {
  TRadius._();

  // Scale (base unit: 4.0)
  static const double xs = 2.0;
  static const double sm = 4.0;
  static const double md = 8.0;
  static const double lg = 12.0;
  static const double xl = 16.0;
  static const double xxl = 24.0;
  static const double xxxl = 32.0;
  static const double full = 9999.0; // pill / circle

  // Semantic Radius
  static const BorderRadius button = BorderRadius.all(Radius.circular(md));
  static const BorderRadius card = BorderRadius.all(Radius.circular(lg));
  static const BorderRadius dialog = BorderRadius.all(Radius.circular(xl));
  static const BorderRadius chip = BorderRadius.all(Radius.circular(full));
  static const BorderRadius inputField = BorderRadius.all(Radius.circular(sm));
  static const BorderRadius tooltip = BorderRadius.all(Radius.circular(xs));
  static const BorderRadius popover = BorderRadius.all(Radius.circular(md));
  static const BorderRadius snackbar = BorderRadius.all(Radius.circular(md));

  // Top / Bottom Specific
  static const BorderRadius topSm = BorderRadius.vertical(
    top: Radius.circular(sm),
  );
  static const BorderRadius topMd = BorderRadius.vertical(
    top: Radius.circular(md),
  );
  static const BorderRadius topLg = BorderRadius.vertical(
    top: Radius.circular(lg),
  );

  static const BorderRadius bottomSm = BorderRadius.vertical(
    bottom: Radius.circular(sm),
  );
  static const BorderRadius bottomMd = BorderRadius.vertical(
    bottom: Radius.circular(md),
  );
  static const BorderRadius bottomLg = BorderRadius.vertical(
    bottom: Radius.circular(lg),
  );

  // Left / Right Specific
  static const BorderRadius leftSm = BorderRadius.horizontal(
    left: Radius.circular(sm),
  );
  static const BorderRadius leftMd = BorderRadius.horizontal(
    left: Radius.circular(md),
  );
  static const BorderRadius leftLg = BorderRadius.horizontal(
    left: Radius.circular(lg),
  );

  static const BorderRadius rightSm = BorderRadius.horizontal(
    right: Radius.circular(sm),
  );
  static const BorderRadius rightMd = BorderRadius.horizontal(
    right: Radius.circular(md),
  );
  static const BorderRadius rightLg = BorderRadius.horizontal(
    right: Radius.circular(lg),
  );

  // Circular Variants
  static const BorderRadius circleSm = BorderRadius.all(Radius.circular(20.0));
  static const BorderRadius circleMd = BorderRadius.all(Radius.circular(40.0));
  static const BorderRadius circleLg = BorderRadius.all(Radius.circular(80.0));

  // Accessibility Variants (larger radius for clearer distinction)
  static const BorderRadius accessibleButton = BorderRadius.all(
    Radius.circular(xl),
  );
  static const BorderRadius accessibleCard = BorderRadius.all(
    Radius.circular(xxl),
  );

  // Utility
  static const BorderRadius none = BorderRadius.zero;
}

///
/// --- Usage Example ---
///
/// To use radius tokens in your widgets:
///
/// ```dart
/// Container(
///   decoration: BoxDecoration(
///     color: Colors.white,
///     borderRadius: TRadius.card,
///   ),
/// )
/// ```
///
/// This ensures consistent corner rounding across the app.
///
