/// Pure utility class for string capitalization, title casing, and text truncations.
abstract final class StringFormatter {
  const StringFormatter._();

  /// Capitalizes the first letter of a string.
  /// Example: StringFormatter.capitalize('hello') -> 'Hello'
  static String capitalize(String text) {
    if (text.trim().isEmpty) return text;
    final clean = text.trim();
    return '${clean[0].toUpperCase()}${clean.substring(1)}';
  }

  /// Converts a string to Title Case (capitalizes the first letter of every word).
  /// Example: StringFormatter.toTitleCase('john doe') -> 'John Doe'
  static String toTitleCase(String text) {
    if (text.trim().isEmpty) return text;
    return text
        .trim()
        .split(RegExp(r'\s+'))
        .map((word) => capitalize(word.toLowerCase()))
        .join(' ');
  }

  /// Capitalizes the first letter of each sentence in a text block.
  /// Example: StringFormatter.toSentenceCase('hello world. how are you?') -> 'Hello world. How are you?'
  static String toSentenceCase(String text) {
    if (text.trim().isEmpty) return text;

    final sentences = text.split(RegExp(r'(?<=[.!?])\s+'));
    final capitalized = sentences.map((sentence) {
      if (sentence.trim().isEmpty) return sentence;
      return capitalize(sentence.trim());
    });

    return capitalized.join(' ');
  }

  /// Truncates text to a maximum length and appends an ellipsis (...) if it exceeds the limit.
  /// Example: StringFormatter.truncate('Long text here', 7) -> 'Long te...'
  static String truncate(
    String text,
    int maxLength, {
    String ellipsis = '...',
  }) {
    if (text.length <= maxLength) return text;
    return '${text.substring(0, maxLength)}$ellipsis';
  }
}
