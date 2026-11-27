import 'dart:convert';

// Import necessary packages and models for configuration, HTTP requests, and state management.
import 'package:gestbanda/config/config.dart';
import 'package:gestbanda/domain/newmodels/codesModels/codes.dart';
import 'package:gestbanda/domain/newmodels/codesModels/create_code_dto.dart';
import 'package:gestbanda/domain/newmodels/voiceModels/voice_dto.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../domain/newmodels/bandModels/band_dto.dart';
import '../../../domain/newmodels/codesModels/codes_provider_dto.dart';

import 'package:http/http.dart' as http;

import '../../../domain/newmodels/roleModels/role_dto.dart';
import '../../../domain/newmodels/userModels/user_dto.dart';
import '../../../config/api_config.dart';
import '../errorProvider/error_provider.dart';
import '../sharedPreferencesProvider/shared_preferences_provider.dart';

// Part directive for generating code with Riverpod annotations.
part 'codes_provider.g.dart';

// A provider class that manages the state and operations related to codes in a band.
@riverpod
class CodesProvider extends _$CodesProvider {
  // API endpoint for making requests.

  // Overrides the build method to initialize the state with default values.
  @override
  CodesProviderDTO build() => CodesProviderDTO(
        codes: [],
        createModifyCode: CodesDTO(
            id: "",
            code: "",
            voice: VoiceDTO(id: "", name: ""),
            endDate: DateTime.now(),
            createdDate: DateTime.now()),
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
        isLoading: false,
      );

  // Fetches the codes associated with the current band and updates the state accordingly.
  Future<void> getBandCodes() async {
    const api = apiUrl;

    if (state.isLoading) return;

    // Start loading
    state.copyWith(isLoading: true);

    await getUser();
    await getBand();
    try {
      final response = await http.get(
        Uri.parse("$api/codes/getBandCodes?id=${state.band.id}"),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': state.user.token,
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);

        if (jsonResponse is List) {
          final List<CodesDTO> listCodes = jsonResponse
              .map((jsonItem) => CodesDTO.fromJson(jsonItem))
              .toList();

          state = state.copyWith(codes: listCodes);
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

  // Creates a new code for the current band and updates the state.
  Future<void> createBandCode() async {
    const api = apiUrl;

    if (state.isLoading) return;

    // Start loading
    state.copyWith(isLoading: true);

    await getUser();
    await getBand();

    CreateUpdateCodeDTO createCodeDTO = CreateUpdateCodeDTO(
      bandID: state.band.id,
      voiceID: state.createModifyCode.voice.id,
      endDate: state.createModifyCode.endDate,
    );

    try {
      final response = await http.post(
        Uri.parse("$api/codes/createBandCode"),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': state.user.token,
        },
        body: jsonEncode(createCodeDTO),
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

  // Updates an existing code for the current band and updates the state.
  Future<void> updateBandCode() async {
    const api = apiUrl;

    if (state.isLoading) return;

    // Start loading
    state.copyWith(isLoading: true);

    await getUser();
    await getBand();

    CreateUpdateCodeDTO updateCodeDTO = CreateUpdateCodeDTO(
      id: state.createModifyCode.id,
      bandID: state.band.id,
      voiceID: state.createModifyCode.voice.id,
      endDate: state.createModifyCode.endDate,
    );

    try {
      final response = await http.put(
        Uri.parse("$api/codes/updateBandCode"),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': state.user.token,
        },
        body: jsonEncode(updateCodeDTO),
      );

      if (response.statusCode == 200) {
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

  // Removes a code from the current band and updates the state.
  Future<void> removeCode(String id) async {
    const api = apiUrl;

    if (state.isLoading) return;

    // Start loading
    state.copyWith(isLoading: true);

    await getUser();
    try {
      final response = await http.delete(
        Uri.parse("$api/codes/deleteBandCode?idCode=$id"),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': state.user.token,
        },
      );

      if (response.statusCode == 200) {
        state = state.copyWith(
          codes: state.codes.where((voice) => voice.id != id).toList(),
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
