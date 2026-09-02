import 'dart:io';

import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

/// Pure utility class for invoking native system share sheets for text, links, and files.
abstract final class ShareHelper {
  const ShareHelper._();

  // ===========================================================================
  // 1. TEXT & LINK SHARING
  // ===========================================================================

  /// Shares plain text with an optional subject line (useful for email clients).
  /// Example: `ShareHelper.shareText('Check out this amazing post!')`
  static Future<ShareResult> shareText(
    String text, {
    String? subject,
    Rect? sharePositionOrigin,
  }) async {
    if (text.trim().isEmpty)
      return const ShareResult('', ShareResultStatus.dismissed);

    return await Share.share(
      text,
      subject: subject,
      sharePositionOrigin: sharePositionOrigin,
    );
  }

  /// Shares a website URL along with optional accompanying descriptive text.
  /// Example: `ShareHelper.shareLink('https://flutter.dev', text: 'Learn Flutter!')`
  static Future<ShareResult> shareLink(
    String url, {
    String? text,
    String? subject,
    Rect? sharePositionOrigin,
  }) async {
    final message = text != null && text.isNotEmpty ? '$text\n$url' : url;

    return await Share.share(
      message,
      subject: subject,
      sharePositionOrigin: sharePositionOrigin,
    );
  }

  // ===========================================================================
  // 2. FILE & MEDIA SHARING
  // ===========================================================================

  /// Shares a single file (image, PDF, document) via native system share sheet.
  /// Example: `ShareHelper.shareFile(File('/path/to/image.png'), text: 'My Photo')`
  static Future<ShareResult> shareFile(
    File file, {
    String? text,
    String? subject,
    Rect? sharePositionOrigin,
  }) async {
    return shareMultipleFiles(
      [file],
      text: text,
      subject: subject,
      sharePositionOrigin: sharePositionOrigin,
    );
  }

  /// Shares multiple files simultaneously (e.g., photo gallery selection).
  /// Example: `ShareHelper.shareMultipleFiles([file1, file2], text: 'Trip Photos')`
  static Future<ShareResult> shareMultipleFiles(
    List<File> files, {
    String? text,
    String? subject,
    Rect? sharePositionOrigin,
  }) async {
    final validFiles = files.where((f) => f.existsSync()).toList();

    if (validFiles.isEmpty) {
      return const ShareResult('', ShareResultStatus.dismissed);
    }

    final xFiles = validFiles.map((f) => XFile(f.path)).toList();

    return await Share.shareXFiles(
      xFiles,
      text: text,
      subject: subject,
      sharePositionOrigin: sharePositionOrigin,
    );
  }

  // ===========================================================================
  // 3. CONVENIENCE HELPERS FOR IPAD / TABLET ORIGINS
  // ===========================================================================

  /// Calculates the bounding box [Rect] of a widget using its [BuildContext].
  /// On iPads, share sheets pop over from a specific button anchor.
  static Rect? getShareOrigin(BuildContext context) {
    final renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox != null && renderBox.hasSize) {
      return renderBox.localToGlobal(Offset.zero) & renderBox.size;
    }
    return null;
  }
}
