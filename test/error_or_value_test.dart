import 'package:error_or_result/error_or_result.dart';
import 'package:test/test.dart';

// Test the ErrorOrValue class
void main() {
  group('A group of ErrorOr tests', () {
    setUp(() {
      // Additional setup goes here.
    });

    test('Successfully Test Returning A desired value', () {
      final now = DateTime.now();
      final result = ErrorOrValue.fromResult(now);
      expect(result.result, isA<DateTime>());
      expect(result.isError, false);
      expect(result.errors.isEmpty, true);
    });
    test('Successfully Test Generating List Of Errors', () {
      final errors = [
        VFailure.validation(),
        VFailure.notFound(),
      ];
      final errorOr = ErrorOrValue<List<String>>.fromErrors(errors);
      expect(errorOr.errors, errorOr.errors);
      expect(errorOr.isError, true);
      expect(errorOr.errors.first.code, VFailure.validation().code);
    });
  });
}
