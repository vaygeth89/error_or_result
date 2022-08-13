import 'package:error_or_result/src/enums.dart';

/// Base class for Value Result
abstract class VResult {}

class VSuccess<TValue> extends VResult {
  final TValue value;
  VSuccess(this.value);
}

class VFailure extends VResult {
  /// The error code is used to identify the error, for example a domain error code when use inputs invalid credentials upon sign in
  final String code;

  /// Further details about the error, for example 'You must provide correct password'
  final String description;

  /// The general category of the error, for example validation error when user inputs invalid credentials
  final ErrorType type;
  VFailure({
    required this.code,
    required this.description,
    required this.type,
  });

  factory VFailure.fromError(VFailure error) {
    return VFailure(
      code: error.code,
      description: error.description,
      type: error.type,
    );
  }

  /// Generic Errors that works for most of the use cases
  factory VFailure.failure(
      {String code = "General.Failure",
      String description = "A failure has occured."}) {
    return VFailure(
      code: code,
      description: description,
      type: ErrorType.failure,
    );
  }
  factory VFailure.unexpected(
      {String code = "General.Unexpected",
      String description = "An unexpected error has occured."}) {
    return VFailure(
      code: code,
      description: description,
      type: ErrorType.failure,
    );
  }
  factory VFailure.validation(
      {String code = "General.Validation",
      String description = "A validation error has occured."}) {
    return VFailure(
      code: code,
      description: description,
      type: ErrorType.failure,
    );
  }
  factory VFailure.conflict(
      {String code = "General.Conflict",
      String description = "A conflict error has occured."}) {
    return VFailure(
      code: code,
      description: description,
      type: ErrorType.failure,
    );
  }
  factory VFailure.notFound(
      {String code = "General.NotFound",
      String description = "A 'Not Found' error has occured."}) {
    return VFailure(
      code: code,
      description: description,
      type: ErrorType.failure,
    );
  }
  factory VFailure.notAllowed(
      {String code = "General.NotAllowed",
      String description = "A 'Not Allowed' error has occured."}) {
    return VFailure(
      code: code,
      description: description,
      type: ErrorType.failure,
    );
  }
}

class ErrorOrValue<T> {
  final bool isError;
  final List<VResult> _result;

  T get result => (_result.first as VSuccess<T>).value;

  List<VFailure> get errors => isError ? _result as List<VFailure> : [];

  ErrorOrValue(this.isError, this._result);

  /// Pass list of [ErrorResult] to create an ErrorOr with and set isError to true
  factory ErrorOrValue.fromErrors(List<VFailure> errors) {
    return ErrorOrValue<T>(true, errors);
  }

  /// Pass [TValue] to create an ErrorOr with and set isError to false
  factory ErrorOrValue.fromResult(T result) {
    return ErrorOrValue<T>(false, [VSuccess<T>(result)]);
  }
}
