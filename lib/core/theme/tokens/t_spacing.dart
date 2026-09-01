import 'package:flutter/material.dart';

/// Design Tokens: Spacing
/// TSpacing defines all spacing values used across the app.
/// Organized by scale, semantic usage, and responsive variants.
class TSpacing {
  TSpacing._();

  // Base Unit
  static const double base = 4.0;

  // Scale (multiples of base unit)
  static const double xs = base; // 4
  static const double sm = base * 2; // 8
  static const double md = base * 3; // 12
  static const double lg = base * 4; // 16
  static const double xl = base * 6; // 24
  static const double xxl = base * 8; // 32
  static const double xxxl = base * 12; // 48
  static const double huge = base * 16; // 64
  static const double gigantic = base * 24; // 96

  // Semantic Spacing
  static const double paddingSmall = sm;
  static const double paddingMedium = lg;
  static const double paddingLarge = xl;

  static const double marginSmall = sm;
  static const double marginMedium = lg;
  static const double marginLarge = xl;

  static const double gapSmall = sm;
  static const double gapMedium = lg;
  static const double gapLarge = xl;

  // Grid System
  static const double gridGutter = lg; // 16
  static const double gridColumnGap = xl; // 24
  static const double gridRowGap = xl; // 24

  // Responsive Breakpoint Spacing
  static const double mobilePadding = md; // 12
  static const double tabletPadding = xl; // 24
  static const double desktopPadding = xxl; // 32
  static const double widescreenPadding = huge; // 64

  // Component Specific Spacing
  static const double buttonPaddingHorizontal = lg; // 16
  static const double buttonPaddingVertical = md; // 12

  static const double cardPadding = xl; // 24
  static const double cardMargin = lg; // 16

  static const double listItemSpacing = md; // 12
  static const double sectionSpacing = xxxl; // 48

  // Icon Spacing
  static const double iconPadding = sm; // 8
  static const double iconMargin = sm; // 8

  // Form Spacing
  static const double formFieldPadding = lg; // 16
  static const double formFieldMargin = md; // 12
  static const double formGroupSpacing = xl; // 24

  // Navigation Spacing
  static const double navItemPadding = md; // 12
  static const double navItemMargin = sm; // 8
  static const double navBarPadding = lg; // 16

  // Dialog / Modal Spacing
  static const double dialogPadding = xxl; // 32
  static const double dialogMargin = xl; // 24
  static const double dialogContentSpacing = lg; // 16

  // Tooltip Spacing
  static const double tooltipPadding = sm; // 8
  static const double tooltipMargin = sm; // 8

  // Chip / Tag Spacing
  static const double chipPaddingHorizontal = md; // 12
  static const double chipPaddingVertical = sm; // 8
  static const double chipMargin = sm; // 8

  // Table Spacing
  static const double tableCellPadding = md; // 12
  static const double tableRowSpacing = sm; // 8
  static const double tableHeaderPadding = lg; // 16

  // Accessibility Variants (larger spacing for readability)
  static const double accessiblePadding = xxl; // 32
  static const double accessibleMargin = xxl; // 32
  static const double accessibleGap = xxxl; // 48

  // Utility Spacing
  static const double none = 0.0;
  static const double auto = double.infinity; // for flexible layouts

  // Custom Spacing Map (for scaling dynamically)
  static const Map<String, double> scale = {
    'xs': xs,
    'sm': sm,
    'md': md,
    'lg': lg,
    'xl': xl,
    'xxl': xxl,
    'xxxl': xxxl,
    'huge': huge,
    'gigantic': gigantic,
  };
}

///
/// --- Usage Example ---
///
/// To use spacing tokens in your widgets:
///
/// ```dart
/// Padding(
///   padding: TSpacing.paddingMd,
///   child: const Text("Hello"),
/// )
/// ```
///
/// This ensures consistent spacing across the app.
