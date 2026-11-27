import 'dart:convert';

import 'package:gestbanda/domain/newmodels/bandModels/band_dto.dart';
import 'package:gestbanda/domain/newmodels/voiceModels/add_voice_to_band_dto.dart';
import 'package:gestbanda/domain/newmodels/voiceModels/voice_dto.dart';
import 'package:gestbanda/domain/newmodels/voiceModels/voice_provider_dto.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../config/config.dart';
import '../../../domain/newmodels/roleModels/role_dto.dart';
import '../../../domain/newmodels/userModels/user_dto.dart';
import '../../../config/api_config.dart';
import '../errorProvider/error_provider.dart';
import '../sharedPreferencesProvider/shared_preferences_provider.dart';
import 'package:http/http.dart' as http;

part 'voices_provider.g.dart';

/// The VoicesProvider class is responsible for managing the state related
/// to voices in a band. It handles fetching, adding, and removing voices
/// from a band, as well as managing user and band information.
@riverpod
class VoicesProvider extends _$VoicesProvider {
  /// Initializes the state of the VoicesProvider with default values
  /// including an empty list of band voices and user and band details.
  @override
  VoiceProviderDTO build() => VoiceProviderDTO(
      bandVoices: [],
      voicesBandNotHave: [],
      user: UserDTO(
          id: "",
          email: "",
          token: "",
          name: "",
          phone: "",
          img: "",
          role: RoleDTO(id: "", name: "", router: ""),
          voz: VoiceDTO(id: "", name: ""),
          instrumentList: [],
          costumeList: []),
      band: BandDTO(
          id: "",
          name: "",
          img: "",
          subscriptionID: "",
          substriptionEndDate: DateTime.now()),
      isLoading: false);

  /// Fetches the list of voices associated with the current band
  /// and updates the state with the retrieved voices. If an error occurs,
  /// it sets an error message in the error provider.
  Future<void> getVoiceList() async {
    const api = apiUrl;

    if (state.isLoading) return;

    // Start loading
    state.copyWith(isLoading: true);

    await getUser();
    await getBand();
    try {
      final response = await http.get(
        Uri.parse("$api/bandVoices/getVoicesBand?id=${state.band.id}"),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': state.user.token,
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);

        if (jsonResponse is List) {
          final List<VoiceDTO> listVoices = jsonResponse
              .map((jsonItem) => VoiceDTO.fromJson(jsonItem))
              .toList();

          state = state.copyWith(bandVoices: listVoices);
        } else {
          ref
              .read(errorProviderProvider.notifier)
              .setError("El formato de respuesta no es una lista.");
        }
      } else {
        final data = json.decode(response.body);
        ref
            .read(errorProviderProvider.notifier)
            .setError(data["message"].toString());
      }
    } catch (e) {
      ref.read(errorProviderProvider.notifier).setError(
          "Ha ocurrido un error en la aplicacion. Intentalo más tarde.");
    } finally {
      state.copyWith(isLoading: false);
    }
  }

  /// Fetches the list of voices that the current band does not have
  /// and updates the state with the retrieved voices. If an error occurs,
  /// it sets an error message in the error provider.
  Future<void> getVoicesBandNotHaveList() async {
    const api = apiUrl;

    if (state.isLoading) return;

    // Start loading
    state.copyWith(isLoading: true);

    await getUser();
    await getBand();
    try {
      final response = await http.get(
        Uri.parse("$api/bandVoices/getVoicesBandNotHave?id=${state.band.id}"),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': state.user.token,
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);

        if (jsonResponse is List) {
          final List<VoiceDTO> listVoices = jsonResponse
              .map((jsonItem) => VoiceDTO.fromJson(jsonItem))
              .toList();

          state = state.copyWith(voicesBandNotHave: listVoices);
        } else {
          ref
              .read(errorProviderProvider.notifier)
              .setError("El formato de respuesta no es una lista.");
        }
      } else {
        final data = json.decode(response.body);
        ref
            .read(errorProviderProvider.notifier)
            .setError(data["message"].toString());
      }
    } catch (e) {
      ref.read(errorProviderProvider.notifier).setError(
          "Ha ocurrido un error en la aplicacion. Intentalo más tarde.");
    } finally {
      state.copyWith(isLoading: false);
    }
  }

  /// Removes a voice from the band by its ID and updates the state accordingly.
  /// If an error occurs, it sets an error message in the error provider.
  Future<void> removeVoiceFromBand(String idVoice) async {
    const api = apiUrl;

    if (state.isLoading) return;

    // Start loading
    state.copyWith(isLoading: true);

    await getUser();
    await getBand();
    try {
      final response = await http.delete(
        Uri.parse(
            "$api/bandVoices/deleteVoiceBand?idVoice=$idVoice&idBand=${state.band.id}"),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': state.user.token,
        },
      );

      if (response.statusCode == 200) {
        // Update the local list by removing the voice by ID
        state = state.copyWith(
          bandVoices:
              state.bandVoices.where((voice) => voice.id != idVoice).toList(),
        );
      } else {
        final data = json.decode(response.body);
        ref
            .read(errorProviderProvider.notifier)
            .setError(data["message"].toString());
      }
    } catch (e) {
      ref.read(errorProviderProvider.notifier).setError(
          "Ha ocurrido un error en la aplicacion. Intentalo más tarde.");
    } finally {
      state.copyWith(isLoading: false);
    }
  }

  /// Adds a voice to the band using the provided voice name and updates the state.
  /// If an error occurs, it sets an error message in the error provider.
  Future<void> addVoiceToBand(String voiceName) async {
    const api = apiUrl;

    if (state.isLoading) return;

    // Start loading
    state.copyWith(isLoading: true);

    await getUser();
    await getBand();

    AddVoiceToBandDTO addVoiceToBandDTO =
        AddVoiceToBandDTO(band_uuid: state.band.id, voice_name: voiceName);

    try {
      final response = await http.post(
        Uri.parse("$api/bandVoices/addVoiceToBand"),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': state.user.token,
        },
        body: jsonEncode(addVoiceToBandDTO),
      );

      if (response.statusCode == 201) {
        final router = await ref.read(appRouterProvider.future);
        router.pop();
      } else {
        final data = json.decode(response.body);
        ref
            .read(errorProviderProvider.notifier)
            .setError(data["message"].toString());
      }
    } catch (e) {
      ref.read(errorProviderProvider.notifier).setError(
          "Ha ocurrido un error en la aplicacion. Intentalo más tarde.");
    } finally {
      state.copyWith(isLoading: false);
    }
  }

  /// Retrieves the current user from SharedPreferences and updates the state.
  /// If the user is not found, an error is set in the error provider.
  Future<void> getUser() async {
    String? userJSON = await ref
        .read(sharedPreferencesProviderProvider.notifier)
        .getString(key: 'user');

    if (userJSON != null) {
      state = state.copyWith(user: UserDTO.fromJson(jsonDecode(userJSON)));
    } else {
      ref
          .read(errorProviderProvider.notifier)
          .setError("No se ha encontrado la sesión del usuario.");
    }
  }

  /// Retrieves the current band from SharedPreferences and updates the state.
  /// If the band is not found, an error is set in the error provider.
  Future<void> getBand() async {
    String? bandJSON = await ref
        .read(sharedPreferencesProviderProvider.notifier)
        .getString(key: 'band');

    if (bandJSON != null) {
      state = state.copyWith(band: BandDTO.fromJson(jsonDecode(bandJSON)));
    } else {
      ref
          .read(errorProviderProvider.notifier)
          .setError("No se ha encontrado la banda en la sesión.");
    }
  }
}
