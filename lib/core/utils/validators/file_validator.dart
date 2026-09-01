import 'dart:io';

import '../formatters/filesize_formatter.dart';

/// Pure utility class for validating file uploads (size limits, allowed extensions).
abstract final class FileValidator {
  const FileValidator._();

  /// Validates a [File] object by size and extension.
  /// Example: FileValidator.validateFile(myPdfFile, allowedExtensions: ['pdf'], maxBytes: 5 * 1024 * 1024)
  static String? validateFile(
    File? file, {
    List<String>? allowedExtensions,
    int? maxBytes,
    String? customErrorMessage,
  }) {
    if (file == null) {
      return 'Please select a file.';
    }

    if (!file.existsSync()) {
      return 'The selected file does not exist.';
    }

    final path = file.path;
    final sizeInBytes = file.lengthSync();

    return validatePathAndSize(
      filePath: path,
      sizeInBytes: sizeInBytes,
      allowedExtensions: allowedExtensions,
      maxBytes: maxBytes,
      customErrorMessage: customErrorMessage,
    );
  }

  /// Validates raw file path and size parameters (useful when working with web pickers or XFile).
  static String? validatePathAndSize({
    required String? filePath,
    required int? sizeInBytes,
    List<String>? allowedExtensions,
    int? maxBytes,
    String? customErrorMessage,
  }) {
    if (filePath == null || filePath.isEmpty) {
      return 'File path is required.';
    }

    // Extension validation
    if (allowedExtensions != null && allowedExtensions.isNotEmpty) {
      final extension = filePath.contains('.')
          ? filePath.split('.').last.toLowerCase()
          : '';

      final normalizedAllowed = allowedExtensions
          .map((ext) => ext.replaceAll('.', '').toLowerCase())
          .toList();

      if (!normalizedAllowed.contains(extension)) {
        return customErrorMessage ??
            'Invalid file type. Allowed: ${normalizedAllowed.join(', ')}';
      }
    }

    // Size validation
    if (maxBytes != null && sizeInBytes != null && sizeInBytes > maxBytes) {
      final maxSizeReadable = FileSizeFormatter.formatBytes(maxBytes);
      return customErrorMessage ??
          'File size exceeds maximum limit of $maxSizeReadable.';
    }

    return null;
  }
}
