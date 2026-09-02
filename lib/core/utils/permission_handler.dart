import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

/// Standardized permission request outcome status.
enum AppPermissionStatus {
  granted,
  denied,
  permanentlyDenied,
  restricted,
  limited;

  bool get isGranted =>
      this == AppPermissionStatus.granted ||
      this == AppPermissionStatus.limited;
  bool get isDenied => this == AppPermissionStatus.denied;
  bool get isPermanentlyDenied => this == AppPermissionStatus.permanentlyDenied;
}

/// Utility class for standardizing mobile device permission requests
/// (Camera, Location, Storage, Notifications, Photos).
abstract final class PermissionHelper {
  const PermissionHelper._();

  // ===========================================================================
  // 1. GENERIC PERMISSION HANDLING
  // ===========================================================================

  /// Checks the current status of a given hardware/OS permission.
  static Future<AppPermissionStatus> checkStatus(Permission permission) async {
    final status = await permission.status;
    return _mapStatus(status);
  }

  /// Requests a single permission and returns the normalized status outcome.
  /// Automatically presents an optional alert dialog to open settings if permanently denied.
  static Future<AppPermissionStatus> requestPermission(
    Permission permission, {
    BuildContext? context,
    String? permanentlyDeniedMessage,
  }) async {
    var status = await permission.status;

    if (status.isGranted) {
      return AppPermissionStatus.granted;
    }

    status = await permission.request();
    final mappedStatus = _mapStatus(status);

    if (mappedStatus.isPermanentlyDenied &&
        context != null &&
        context.mounted) {
      await showAppSettingsDialog(
        context,
        message:
            permanentlyDeniedMessage ??
            'This feature requires ${permission.toString().split('.').last} permission. Please enable it in system settings.',
      );
    }

    return mappedStatus;
  }

  /// Requests multiple permissions simultaneously in a batch.
  static Future<Map<Permission, AppPermissionStatus>> requestMultiple(
    List<Permission> permissions,
  ) async {
    final statuses = await permissions.request();
    return statuses.map((key, value) => MapEntry(key, _mapStatus(value)));
  }

  // ===========================================================================
  // 2. SPECIALIZED FEATURE PERMISSION CONVENIENCE METHODS
  // ===========================================================================

  /// Requests Camera permission for image capture / QR scanning.
  static Future<AppPermissionStatus> requestCamera({BuildContext? context}) {
    return requestPermission(
      Permission.camera,
      context: context,
      permanentlyDeniedMessage:
          'Camera access is required to take photos or scan codes.',
    );
  }

  /// Requests Location permission (When In Use).
  static Future<AppPermissionStatus> requestLocation({BuildContext? context}) {
    return requestPermission(
      Permission.locationWhenInUse,
      context: context,
      permanentlyDeniedMessage:
          'Location access is required to show nearby services.',
    );
  }

  /// Requests Push Notification permission.
  static Future<AppPermissionStatus> requestNotifications({
    BuildContext? context,
  }) {
    return requestPermission(
      Permission.notification,
      context: context,
      permanentlyDeniedMessage:
          'Notifications are required to send order updates and alerts.',
    );
  }

  /// Requests Storage/Photos library permission.
  /// Automatically checks [Permission.photos] for iOS/Android 13+ and [Permission.storage] for legacy Android.
  static Future<AppPermissionStatus> requestPhotosOrStorage({
    BuildContext? context,
  }) async {
    final photoStatus = await requestPermission(
      Permission.photos,
      context: context,
      permanentlyDeniedMessage:
          'Access to photo gallery is required to select images.',
    );

    if (photoStatus.isGranted) return photoStatus;

    return requestPermission(
      Permission.storage,
      context: context,
      permanentlyDeniedMessage:
          'Storage access is required to save and upload files.',
    );
  }

  // ===========================================================================
  // 3. SYSTEM APP SETTINGS DIALOG
  // ===========================================================================

  /// Opens the device settings page for this application.
  static Future<bool> openSystemSettings() async {
    return await openAppSettings();
  }

  /// Prompts a standard dialog offering to redirect the user to System App Settings.
  static Future<void> showAppSettingsDialog(
    BuildContext context, {
    required String message,
    String title = 'Permission Required',
  }) async {
    await showDialog<void>(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(ctx).pop(),
            ),
            TextButton(
              child: const Text('Open Settings'),
              onPressed: () {
                Navigator.of(ctx).pop();
                openSystemSettings();
              },
            ),
          ],
        );
      },
    );
  }

  // ===========================================================================
  // 4. PRIVATE MAPPING HELPERS
  // ===========================================================================

  static AppPermissionStatus _mapStatus(PermissionStatus status) {
    switch (status) {
      case PermissionStatus.granted:
        return AppPermissionStatus.granted;
      case PermissionStatus.denied:
        return AppPermissionStatus.denied;
      case PermissionStatus.permanentlyDenied:
        return AppPermissionStatus.permanentlyDenied;
      case PermissionStatus.restricted:
        return AppPermissionStatus.restricted;
      case PermissionStatus.limited:
        return AppPermissionStatus.limited;
      case PermissionStatus.provisional:
        return AppPermissionStatus.granted;
    }
  }
}
