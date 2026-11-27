import 'package:flutter_test/flutter_test.dart';
import 'package:gestbanda/domain/newmodels/codesModels/codes.dart';

void main() {
  test('codes stay text and keep their leading zeros', () {
    expect(invitationCodeFromJson('004821'), '004821');
    expect(invitationCodeFromJson(4821), '004821');
    expect(invitationCodeFromJson(null), '');
  });
}
