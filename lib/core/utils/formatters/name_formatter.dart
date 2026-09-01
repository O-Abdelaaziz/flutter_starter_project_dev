/// Pure utility class for formatting names, titles, and person-related strings.
/// Zero UI state or framework dependencies.
abstract final class NameFormatter {
  const NameFormatter._();

  /// Capitalizes the first letter of each word in a name.
  /// Example: 'john doe' -> 'John Doe'
  /// Example: 'MARY-JANE O'CONNOR' -> 'Mary-Jane O'Connor'
  static String capitalizeWords(String? name) {
    if (name == null || name.trim().isEmpty) return '';

    return name
        .trim()
        .toLowerCase()
        .split(RegExp(r'\s+'))
        .map((word) {
          if (word.isEmpty) return '';

          // Handle hyphenated names like "mary-jane"
          if (word.contains('-')) {
            return word
                .split('-')
                .map((part) {
                  if (part.isEmpty) return '';
                  return part[0].toUpperCase() + part.substring(1);
                })
                .join('-');
          }

          return word[0].toUpperCase() + word.substring(1);
        })
        .join(' ');
  }

  /// Extracts up to [maxInitials] uppercase initials from a person's name for UI avatars.
  /// Example: 'John Doe' -> 'JD'
  /// Example: 'Single' -> 'S'
  static String getInitials(String? name, {int maxInitials = 2}) {
    if (name == null || name.trim().isEmpty) return '';

    final cleanName = name.trim();
    final parts = cleanName.split(RegExp(r'\s+'));

    if (parts.length == 1) {
      return parts.first.substring(0, 1).toUpperCase();
    }

    final buffer = StringBuffer();
    final count = parts.length < maxInitials ? parts.length : maxInitials;

    for (var i = 0; i < count; i++) {
      if (parts[i].isNotEmpty) {
        buffer.write(parts[i][0].toUpperCase());
      }
    }

    return buffer.toString();
  }

  /// Formats a first and last name combination.
  /// Example: formatFirstAndLast('John', 'Doe') -> 'John Doe'
  static String formatFirstAndLast(String? firstName, String? lastName) {
    final first = capitalizeWords(firstName);
    final last = capitalizeWords(lastName);

    if (first.isEmpty) return last;
    if (last.isEmpty) return first;
    return '$first $last';
  }

  /// Safely truncates a name for tight UI containers with an ellipsis.
  /// Example: 'Christopher Montgomery', maxLength: 12 -> 'Christopher…'
  static String truncateName(String? name, {int maxLength = 15}) {
    if (name == null || name.isEmpty) return '';
    if (name.length <= maxLength) return name;

    return '${name.substring(0, maxLength).trim()}…';
  }
}
