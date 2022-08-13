import 'package:error_or_result/error_or_result.dart';
import 'package:error_or_result/src/enums.dart';

/// Base class for ErrorOrResult and ErrorOrValue
class ErrorOr<TValue> {
  /// The [TValue] value that you expect to return when successful
  TValue? _result;
  bool _isError = false;
  final List<ErrorResult> _errors;

  ErrorOr(this._result, this._isError, this._errors);

  /// Pass single [ErrorResult] to create an ErrorOr with and set isError to true
  factory ErrorOr.fromError(ErrorResult error) {
    return ErrorOr(null, true, [error]);
  }

  /// Pass list of [ErrorResult] to create an ErrorOr with and set isError to true
  factory ErrorOr.fromErrors(List<ErrorResult> errors) {
    return ErrorOr(null, true, errors);
  }

  /// Pass [TValue] to create an ErrorOr with and set isError to false
  factory ErrorOr.fromResult(TValue result) {
    return ErrorOr(result, false, []);
  }

  bool get isError => _isError;
  TValue get result => _result!;
  List<ErrorResult> get errors => _errors;
  ErrorResult get firstError => _errors.first;

  @override
  String toString() {
    if (_isError) {
      return 'ErrorOr<$TValue> {error: ${firstError.description}}';
    }
    return 'ErrorOr<$TValue> {result: $result}';
  }
}

/// The encapsulation of the error details
class ErrorResult {
  /// The error code is used to identify the error, for example a domain error code when use inputs invalid credentials upon sign in
  final String code;

  /// Further details about the error, for example 'You must provide correct password'
  final String description;

  /// The general category of the error, for example validation error when user inputs invalid credentials
  final ErrorType type;
  const ErrorResult({
    required this.code,
    required this.description,
    required this.type,
  });

  /// Generic Errors that works for most of the use cases
  factory ErrorResult.failure(
      {String code = "General.Failure",
      String description = "A failure has occured."}) {
    return ErrorResult(
      code: code,
      description: description,
      type: ErrorType.failure,
    );
  }
  factory ErrorResult.unexpected(
      {String code = "General.Unexpected",
      String description = "An unexpected error has occured."}) {
    return ErrorResult(
      code: code,
      description: description,
      type: ErrorType.failure,
    );
  }
  factory ErrorResult.validation(
      {String code = "General.Validation",
      String description = "A validation error has occured."}) {
    return ErrorResult(
      code: code,
      description: description,
      type: ErrorType.failure,
    );
  }
  factory ErrorResult.conflict(
      {String code = "General.Conflict",
      String description = "A conflict error has occured."}) {
    return ErrorResult(
      code: code,
      description: description,
      type: ErrorType.failure,
    );
  }
  factory ErrorResult.notFound(
      {String code = "General.NotFound",
      String description = "A 'Not Found' error has occured."}) {
    return ErrorResult(
      code: code,
      description: description,
      type: ErrorType.failure,
    );
  }
  factory ErrorResult.notAllowed(
      {String code = "General.NotAllowed",
      String description = "A 'Not Allowed' error has occured."}) {
    return ErrorResult(
      code: code,
      description: description,
      type: ErrorType.failure,
    );
  }
}
