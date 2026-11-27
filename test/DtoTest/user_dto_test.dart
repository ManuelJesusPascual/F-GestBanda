import 'package:flutter_test/flutter_test.dart';
import 'package:gestbanda/domain/newmodels/roleModels/role_dto.dart';
import 'package:gestbanda/domain/newmodels/userModels/user_dto.dart';
import 'package:gestbanda/domain/newmodels/voiceModels/voice_dto.dart';

void main() {
  test('role and voice survive a JSON round trip', () {
    final user = UserDTO(
      id: 'u1',
      name: 'Usuario de ejemplo',
      email: 'usuario@example.com',
      phone: '600000000',
      token: 't',
      role: RoleDTO(id: 'r1', name: 'COMPONENTE', router: ''),
      voz: VoiceDTO(id: 'v1', name: 'Corneta'),
    );

    final json = user.toJson();
    expect(json.containsKey('voz'), isFalse);
    expect(json['voice'], isNotNull);

    final parsed = UserDTO.fromJson(json);
    expect(parsed.role?.name, 'COMPONENTE');
    expect(parsed.voz?.id, 'v1');
  });

  test('a user without role or voice parses with nulls', () {
    final parsed = UserDTO.fromJson({
      'id': 'u1',
      'name': 'Usuario de ejemplo',
      'email': 'usuario@example.com',
      'phone': '600000000',
    });
    expect(parsed.role, isNull);
    expect(parsed.voz, isNull);
  });
}
