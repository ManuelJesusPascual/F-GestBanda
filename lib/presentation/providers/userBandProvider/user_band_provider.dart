import 'dart:convert';

import 'package:gestbanda/domain/newmodels/userBandsModels/modify_user_bands_dto.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../config/router/routes_config.dart';
import '../../../domain/newmodels/bandModels/band_dto.dart';
import '../../../domain/newmodels/roleModels/role_dto.dart';
import '../../../domain/newmodels/userBandsModels/user_band_provider_dto.dart';
import '../../../domain/newmodels/userBandsModels/user_bands_dto.dart';

import 'package:http/http.dart' as http;

import '../../../domain/newmodels/userModels/user_dto.dart';
import '../../../domain/newmodels/voiceModels/voice_dto.dart';
import '../../../config/api_config.dart';
import '../errorProvider/error_provider.dart';
import '../sharedPreferencesProvider/shared_preferences_provider.dart';

part 'user_band_provider.g.dart';

/// The UserBandProvider class is responsible for managing the state
/// related to user bands, including fetching, modifying, and removing
/// user band associations. It uses Riverpod for state management
/// and handles API interactions for user band operations.
@riverpod
class UserBandProvider extends _$UserBandProvider {
  /// Overrides the build method to initialize the UserBandProviderDTO
  /// with default values for user bands, user details, and loading state.
  @override
  UserBandProviderDTO build() => UserBandProviderDTO(
        userBands: [],
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
        userModify: UserDTO(
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

  /// Asynchronously removes a user from a band by making a DELETE request
  /// to the API. Handles loading state and manages potential errors
  /// that may occur during the operation.
  Future<void> removeUserBand() async {
    const api = apiUrl;

    if (state.isLoading) return;

    // Start loading
    state.copyWith(isLoading: true);

    await getUser();
    try {
      final response = await http.delete(
        Uri.parse(
            "$api/userBands/deleteUserBand?idUser=${state.userModify.id}&idBand=${state.band.id}"),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': state.user.token,
        },
      );

      if (response.statusCode == 200) {
        await getUserBands();

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

  /// Asynchronously modifies a user's band association by making a PUT request
  /// to the API. It starts by loading the current user and band information
  /// before sending the modification request and handling any errors.
  Future<void> modifyUserBand(UserDTO user) async {
    const api = apiUrl;

    if (state.isLoading) return;

    // Start loading
    state.copyWith(isLoading: true);

    await getUser();
    await getBand();

    ModifyUserBandsDTO userModify = ModifyUserBandsDTO(
        userId: state.userModify.id,
        voiceId: user.voz!.id,
        roleId: user.role!.id,
        bandId: state.band.id);

    try {
      final response = await http.put(
        Uri.parse("$api/userBands/modifyUserBand"),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': state.user.token,
        },
        body: jsonEncode(userModify.toJson()),
      );

      if (response.statusCode == 200) {
        await getUserBands();
        state.userModify =
            state.userModify.copyWith(voz: user.voz, role: user.role);
        final router = await ref.read(appRouterProvider.future);
        router.pop(state.userModify);
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

  /// Updates the userModify state with the provided UserDTO.
  /// This method is used to set the user data that is being modified.
  void updateUserModify(UserDTO user) {
    state = state.copyWith(userModify: user);
  }

  /// Retrieves the list of user bands associated with the current band
  /// by making a GET request to the API. It manages the loading state
  /// and handles errors that may arise during the request.
  Future<void> getUserBands() async {
    const api = apiUrl;

    if (state.isLoading) return;

    // Start loading
    state.copyWith(isLoading: true);

    await getUser();
    await getBand();
    try {
      final response = await http.get(
        Uri.parse("$api/userBands/getBandUsers?id=${state.band.id}"),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': state.user.token,
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);

        if (jsonResponse is List) {
          final List<UserBandsDTO> listUsers = jsonResponse
              .map((jsonItem) => UserBandsDTO.fromJson(jsonItem))
              .toList();

          state = state.copyWith(userBands: listUsers);
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
