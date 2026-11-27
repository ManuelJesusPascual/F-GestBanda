import '../userModels/user_dto.dart';

/// What the current user may do in the current band, from their role.
///
/// Mirrors the rules the API enforces (it answers 403 otherwise), so the UI
/// can hide what the user is not allowed to do:
/// - DIRECTOR: manage voices, invitation codes and every member.
/// - JEFE DE VOZ: change the voice of, or remove, COMPONENTE members of their
///   own voice. Cannot change roles.
/// - COMPONENTE: read only.
class BandPermissions {
  static const String director = 'DIRECTOR';
  static const String voiceLeader = 'JEFE DE VOZ';
  static const String member = 'COMPONENTE';

  /// No band or no session: nothing is allowed.
  static const BandPermissions none = BandPermissions(role: '');

  final String role;
  final String? voiceId;

  const BandPermissions({required this.role, this.voiceId});

  bool get isDirector => _normalize(role) == director;
  bool get isVoiceLeader => _normalize(role) == voiceLeader;

  bool get canManageVoices => isDirector;
  bool get canManageCodes => isDirector;
  bool get canChangeRoles => isDirector;

  /// Whether the user can edit or remove [other] from the band.
  bool canManageMember(UserDTO other) {
    if (isDirector) return true;
    return isVoiceLeader &&
        _normalize(other.role?.name ?? '') == member &&
        voiceId != null &&
        other.voz?.id == voiceId;
  }

  static String _normalize(String role) => role.trim().toUpperCase();
}
