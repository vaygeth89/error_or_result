// Common Enums
/// Error types
enum ErrorType {
  failure,
  unexpected,
  validation,
  conflict,
  unauthorized,
  notFound;

  /// Return the string of the enum value
  String get description => name;
}
