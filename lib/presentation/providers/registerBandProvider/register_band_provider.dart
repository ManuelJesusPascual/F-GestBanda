import 'package:gestbanda/utils/api_errors.dart';
import 'dart:convert';

import 'package:gestbanda/domain/newmodels/bandModels/band_dto.dart';
import 'package:gestbanda/domain/newmodels/bandModels/register_band_dto.dart';
import 'package:gestbanda/domain/newmodels/userModels/user_dto.dart';
import 'package:gestbanda/presentation/providers/sharedPreferencesProvider/shared_preferences_provider.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:gestbanda/utils/extensions.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:http/http.dart' as http;

import '../../../config/config.dart';
import '../../../domain/newmodels/roleModels/role_dto.dart';
import '../../../domain/newmodels/voiceModels/voice_dto.dart';
import '../../../config/api_config.dart';
import '../errorProvider/error_provider.dart';

part 'register_band_provider.g.dart';

/// Provider for handling band registration logic.
/// This class manages the registration form state and handles interactions
/// with the API to register a new band.
@riverpod
class RegisterBandProvider extends _$RegisterBandProvider {
  /// State to indicate if a request is currently loading
  bool isLoading = false;

  // Initial state, setting default values for a new RegisterBandDTO object.
  @override
  RegisterBandDTO build() => RegisterBandDTO(
      name: "",
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
      img: XFile(""));

  /// Updates the band name in the state.
  /// Ensures that the state only updates if the new name is different.
  void changeName(String name) {
    if (state.name != name) {
      state = state.copyWith(name: name);
    }
  }

  /// Validates the band name format.
  /// Returns an error message if invalid, otherwise returns null.
  String? validateBandName(String? val) {
    if (val != null && val.isValidBandName) {
      return null;
    }
    return "Debes introducir un nombre de banda válido";
  }

  /// Retrieves the current user from SharedPreferences and updates the state.
  /// Sets an error if the user session is not found.
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

  /// Opens the image picker to select an image for the band.
  /// If an image is selected, it updates the state's `img` property.
  Future<void> selectImage() async {
    final ImagePicker picker = ImagePicker();

    final XFile? image =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 25);
    if (image != null) {
      state = state.copyWith(img: image);
    }
  }

  /// Validates that an image has been selected.
  /// Displays an error message if no image is found.
  bool validateImage() {
    bool valid = false;

    if (state.img.path.isEmpty) {
      ref
          .read(errorProviderProvider.notifier)
          .setError("Debes introducir una imagen.");
    } else {
      valid = true;
    }
    return valid;
  }

  /// Registers the band by sending data to the API.
  /// This includes the band details in JSON and the selected image as a file.
  Future<void> registerBand() async {
    const api = apiUrl;

    if (isLoading) return;

    // Start loading
    isLoading = true;
    try {
      await getUser(); // Ensure user details are available

      final request = http.MultipartRequest(
        'POST',
        Uri.parse("$api/band/registerBand"),
      );

      // Attach the image file
      request.files
          .add(await http.MultipartFile.fromPath('img', state.img.path));

      // Attach the band details in JSON format
      request.files.add(http.MultipartFile.fromString(
          'createBandRequest', jsonEncode(state.toJson()),
          contentType: MediaType('application', 'json', {'charset': 'utf-8'})));
      request.headers['Authorization'] = state.user.token;

      // Send the request
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      // Handle API response
      if (response.statusCode == 201) {
        final jsonResponse = jsonDecode(response.body);

        // Save band details in SharedPreferences
        final BandDTO band = BandDTO.fromJson(jsonResponse);

        await ref
            .read(sharedPreferencesProviderProvider.notifier)
            .saveString(key: "band", value: json.encode(band.toJson()));
        ref.read(appRouterProvider.notifier).changeRouter(directorRouter);
        final router = await ref.read(appRouterProvider.future);
        router.push("/");
      } else {
        await handleApiError(ref, response);
      }
    } catch (e) {
      ref.read(errorProviderProvider.notifier).setError(
          "Ha ocurrido un error en la aplicacion. Intentalo más tarde.");
    } finally {
      isLoading = false;
    }
  }
}
