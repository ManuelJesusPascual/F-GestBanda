import 'package:flutter_test/flutter_test.dart';
import 'package:gestbanda/domain/newmodels/roleModels/band_permissions.dart';
import 'package:gestbanda/domain/newmodels/roleModels/role_dto.dart';
import 'package:gestbanda/domain/newmodels/userModels/user_dto.dart';
import 'package:gestbanda/domain/newmodels/voiceModels/voice_dto.dart';

UserDTO memberWith(String role, String voiceId) => UserDTO(
      id: 'u-$role-$voiceId',
      name: 'Usuario de ejemplo',
      email: 'usuario@example.com',
      phone: '600000000',
      token: '',
      role: RoleDTO(id: role, name: role, router: ''),
      voz: VoiceDTO(id: voiceId, name: voiceId),
    );

void main() {
  const director = BandPermissions(role: 'DIRECTOR', voiceId: 'v1');
  const voiceLeader = BandPermissions(role: 'JEFE DE VOZ', voiceId: 'v1');
  const member = BandPermissions(role: 'COMPONENTE', voiceId: 'v1');

  test('only DIRECTOR manages voices, codes and roles', () {
    for (final p in [director, voiceLeader, member, BandPermissions.none]) {
      final expected = identical(p, director);
      expect(p.canManageVoices, expected, reason: p.role);
      expect(p.canManageCodes, expected, reason: p.role);
      expect(p.canChangeRoles, expected, reason: p.role);
    }
  });

  test('DIRECTOR manages every member', () {
    expect(director.canManageMember(memberWith('DIRECTOR', 'v2')), isTrue);
    expect(director.canManageMember(memberWith('COMPONENTE', 'v2')), isTrue);
  });

  test('JEFE DE VOZ manages only COMPONENTE members of their voice', () {
    expect(voiceLeader.canManageMember(memberWith('COMPONENTE', 'v1')), isTrue);
    expect(
        voiceLeader.canManageMember(memberWith('COMPONENTE', 'v2')), isFalse);
    expect(
        voiceLeader.canManageMember(memberWith('JEFE DE VOZ', 'v1')), isFalse);
    expect(voiceLeader.canManageMember(memberWith('DIRECTOR', 'v1')), isFalse);
  });

  test('COMPONENTE and no session manage nobody', () {
    expect(member.canManageMember(memberWith('COMPONENTE', 'v1')), isFalse);
    expect(BandPermissions.none.canManageMember(memberWith('COMPONENTE', 'v1')),
        isFalse);
  });

  test('role names are compared ignoring case and spaces', () {
    expect(const BandPermissions(role: ' Director ').isDirector, isTrue);
  });
}
