import 'package:error_or_result/error_or_result.dart';
import 'package:test/test.dart';

void main() {
  group('A group of ErrorOr tests', () {
    setUp(() {
      // Additional setup goes here.
    });

    test('Successfully Test Returning A desired value', () {
      final now = DateTime.now();
      final result = ErrorOr.fromResult(now);
      expect(result.result, isA<DateTime>());
      expect(result.isError, false);
      expect(result.errors.isEmpty, true);
    });
    test('Successfully Test Generating List Of ErrorResult', () {
      final errors = [
        ErrorResult.validation(),
        ErrorResult.notFound(),
      ];
      final errorOr = ErrorOr.fromErrors(errors);
      expect(errorOr.errors, errorOr.errors);
      expect(errorOr.isError, true);
      expect(errorOr.firstError.code, ErrorResult.validation().code);
    });
  });
}
