import 'package:flutter_test/flutter_test.dart';
import 'package:gestbanda/domain/newmodels/bandModels/join_band_dto.dart';
import 'package:gestbanda/domain/newmodels/bandModels/register_band_dto.dart';
import 'package:gestbanda/domain/newmodels/userModels/user_dto.dart';
import 'package:image_picker/image_picker.dart';

final user = UserDTO(
  id: 'u1',
  name: 'Usuario de ejemplo',
  email: 'usuario@example.com',
  phone: '600000000',
  token: 'secret-token',
);

void main() {
  test('joinBandByCode body only carries the code', () {
    expect(
        JoinBandDTO(code: '004821', user: user).toJson(), {'code': '004821'});
  });

  test('registerBand body does not carry the user or its token', () {
    expect(
        RegisterBandDTO(
                name: 'Banda de ejemplo', img: XFile('logo.png'), user: user)
            .toJson(),
        {'name': 'Banda de ejemplo'});
  });
}
