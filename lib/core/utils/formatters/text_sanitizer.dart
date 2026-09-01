/// Pure utility class for cleaning, sanitizing, and escaping text inputs/outputs.
abstract final class TextSanitizer {
  const TextSanitizer._();

  /// Strips all HTML tags from a string (useful when displaying backend rich-text in plain Text widgets).
  /// Example: '<b>Hello</b> <script>alert("x")</script>World' -> 'Hello World'
  static String stripHtml(String? htmlString) {
    if (htmlString == null || htmlString.trim().isEmpty) return '';

    // Remove script/style tag contents entirely first
    final cleanScript = htmlString
        .replaceAll(
          RegExp(r'<script[^>]*>[\s\S]*?<\/script>', caseSensitive: false),
          '',
        )
        .replaceAll(
          RegExp(r'<style[^>]*>[\s\S]*?<\/style>', caseSensitive: false),
          '',
        );

    // Replace <br> and </p> with newlines for natural text flow
    final formatted = cleanScript
        .replaceAll(RegExp(r'<br\s*[\/]?>', caseSensitive: false), '\n')
        .replaceAll(RegExp(r'<\/p>', caseSensitive: false), '\n');

    // Strip remaining tags
    final stripped = formatted.replaceAll(RegExp(r'<[^>]*>'), '');

    return unescapeHtml(stripped).trim();
  }

  /// Escapes special HTML characters to prevent breaking raw markup or UI views.
  /// Example: 'John & "Jane"' -> 'John &amp; &quot;Jane&quot;'
  static String escapeHtml(String? text) {
    if (text == null || text.isEmpty) return '';

    return text
        .replaceAll('&', '&amp;')
        .replaceAll('<', '&lt;')
        .replaceAll('>', '&gt;')
        .replaceAll('"', '&quot;')
        .replaceAll("'", '&#39;');
  }

  /// Converts standard HTML entities back into plain characters.
  /// Example: 'Tom &amp; Jerry' -> 'Tom & Jerry'
  static String unescapeHtml(String? text) {
    if (text == null || text.isEmpty) return '';

    return text
        .replaceAll('&amp;', '&')
        .replaceAll('&lt;', '<')
        .replaceAll('&gt;', '>')
        .replaceAll('&quot;', '"')
        .replaceAll('&#39;', "'")
        .replaceAll('&nbsp;', ' ');
  }

  /// Normalizes whitespace by compressing multiple spaces/tabs into a single space and trimming empty lines.
  /// Example: 'Hello    World \n\n  Next' -> 'Hello World \n Next'
  static String normalizeSpaces(String? text) {
    if (text == null || text.isEmpty) return '';

    return text
        .replaceAll(RegExp(r'[ \t]+'), ' ')
        .replaceAll(RegExp(r'\n\s*\n'), '\n')
        .trim();
  }

  /// Removes invisible control characters, non-printable symbols, and zero-width spaces.
  static String removeControlCharacters(String? text) {
    if (text == null || text.isEmpty) return '';

    return text.replaceAll(
      RegExp(r'[\x00-\x1F\x7F-\x9F\u200B-\u200D\uFEFF]'),
      '',
    );
  }
}
