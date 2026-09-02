import 'package:flutter/material.dart';

import '../../../core/utils/device_utils.dart';

/// Responsive builder displaying distinct layouts based on active screen breakpoints.
/// Evaluates viewports via [DeviceUtils] (<600dp: Mobile, 600–1024dp: Tablet, >1024dp: Desktop).
class ResponsiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;

  const ResponsiveLayout({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
  });

  @override
  Widget build(BuildContext context) {
    if (DeviceUtils.isDesktopScreen(context)) {
      return desktop ?? tablet ?? mobile;
    }

    if (DeviceUtils.isTablet(context)) {
      return tablet ?? mobile;
    }

    return mobile;
  }
}

// import 'package:flutter/material.dart';
// import '../../../core/utils/device/responsive_utils.dart';

// /// Responsive builder displaying distinct layouts based on active screen breakpoints.
// class ResponsiveLayout extends StatelessWidget {
//   final Widget mobile;
//   final Widget? tablet;
//   final Widget? desktop;

//   const ResponsiveLayout({
//     super.key,
//     required this.mobile,
//     this.tablet,
//     this.desktop,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final deviceType = ResponsiveUtils.getDeviceType(context);

//     switch (deviceType) {
//       case DeviceType.desktop:
//         return desktop ?? tablet ?? mobile;
//       case DeviceType.tablet:
//         return tablet ?? mobile;
//       case DeviceType.mobile:
//         return mobile;
//     }
//   }
// }
