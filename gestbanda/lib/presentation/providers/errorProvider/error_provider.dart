import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'error_provider.g.dart';

/// Provider that we will use to display errors on the screen.
@riverpod
class ErrorProvider extends _$ErrorProvider {
  @override
  String build() {
    return "";
  }

  /// Method that sets the error message.
  void setError(String error) {
    state = error;
  }
}
