import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'error_provider.g.dart';

@riverpod
class ErrorProvider extends _$ErrorProvider {
  @override
  String build() {
    return "";
  }

  void setError(String error) {
    state = error;
  }
}
