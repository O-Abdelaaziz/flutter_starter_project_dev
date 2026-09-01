/// Pure utility class for formatting addresses into consistent single-line or multi-line strings.
/// Prevents awkward trailing commas or empty spaces when optional fields (like unit/apartment) are missing.
abstract final class AddressFormatter {
  const AddressFormatter._();

  /// Formats an address into a clean single-line string suitable for list cards or table rows.
  /// Example: '123 Main St, Apt 4B, New York, NY, 10001, USA'
  static String formatSingleLine({
    String? street,
    String? unitOrApt,
    String? city,
    String? state,
    String? postalCode,
    String? country,
  }) {
    final components = <String>[];

    if (_hasValue(street)) components.add(street!.trim());
    if (_hasValue(unitOrApt)) components.add(unitOrApt!.trim());
    if (_hasValue(city)) components.add(city!.trim());

    // Combine State and Postal Code together if both exist
    if (_hasValue(state) && _hasValue(postalCode)) {
      components.add('${state!.trim()} ${postalCode!.trim()}');
    } else {
      if (_hasValue(state)) components.add(state!.trim());
      if (_hasValue(postalCode)) components.add(postalCode!.trim());
    }

    if (_hasValue(country)) components.add(country!.trim());

    return components.join(', ');
  }

  /// Formats an address into a multi-line block suitable for invoice headers or shipping labels.
  /// Example:
  /// 123 Main St, Apt 4B
  /// New York, NY 10001
  /// USA
  static String formatMultiLine({
    String? street,
    String? unitOrApt,
    String? city,
    String? state,
    String? postalCode,
    String? country,
  }) {
    final lines = <String>[];

    // Line 1: Street + Unit
    final streetParts = <String>[];
    if (_hasValue(street)) streetParts.add(street!.trim());
    if (_hasValue(unitOrApt)) streetParts.add(unitOrApt!.trim());
    if (streetParts.isNotEmpty) lines.add(streetParts.join(', '));

    // Line 2: City, State Zip
    final cityStateParts = <String>[];
    if (_hasValue(city)) cityStateParts.add(city!.trim());

    if (_hasValue(state) && _hasValue(postalCode)) {
      cityStateParts.add('${state!.trim()} ${postalCode!.trim()}');
    } else {
      if (_hasValue(state)) cityStateParts.add(state!.trim());
      if (_hasValue(postalCode)) cityStateParts.add(postalCode!.trim());
    }
    if (cityStateParts.isNotEmpty) lines.add(cityStateParts.join(', '));

    // Line 3: Country
    if (_hasValue(country)) lines.add(country!.trim());

    return lines.join('\n');
  }

  /// Helper to check if a string contains non-whitespace content.
  static bool _hasValue(String? value) =>
      value != null && value.trim().isNotEmpty;
}
