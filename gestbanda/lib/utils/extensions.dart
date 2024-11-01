extension StringExtension on String {
  bool get isValidEmail {
    final emailRegExp = RegExp(r'^[\w\ñÑ.-]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegExp.hasMatch(this);
  }

  bool get isValidName {
    final nameRegExp = RegExp(r'^[a-zA-ZñÑáéíóúÁÉÍÓÚ ]+$');
    return nameRegExp.hasMatch(this);
  }

  bool get isValidBandName {
    final bandNameRegExp = RegExp(r'^[a-zA-ZñÑáéíóúÁÉÍÓÚ. ]+$');
    return bandNameRegExp.hasMatch(this);
  }

  bool get isValidCode {
    final codeRegExp = RegExp(r'^[0-9]+$');
    return codeRegExp.hasMatch(this);
  }

  bool get isValidPhone {
    final phoneRegExp = RegExp(r'^[67]\d{8}$');
    return phoneRegExp.hasMatch(this);
  }

  bool get isValidPasswordLength {
    final passwordRegExp = RegExp(r'^.{8,}$');
    return passwordRegExp.hasMatch(this);
  }

  bool get isValidPasswordMayus {
    final passwordRegExp = RegExp(r'^(?=.*[A-ZÑÁÉÍÓÚ]).*$');
    return passwordRegExp.hasMatch(this);
  }

  bool get isValidPasswordMinus {
    final passwordRegExp = RegExp(r'^(?=.*[a-zñáéíóú]).*$');
    return passwordRegExp.hasMatch(this);
  }

  bool get isValidPasswordNumber {
    final passwordRegExp = RegExp(r'^(?=.*?[0-9]).*$');
    return passwordRegExp.hasMatch(this);
  }

  bool get isValidPasswordSpecialCharacters {
    final passwordRegExp =
        RegExp(r'^(?=.*?[#?!@$%^&*\-+=_/~.,<>;:{}[\]()|\\]).*$');
    return passwordRegExp.hasMatch(this);
  }

  bool get isValidPassword {
    final passwordRegExp = RegExp(
        r'^(?=.*?[A-ZÑÁÉÍÓÚ])(?=.*?[a-zñáéíóú])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$');
    return passwordRegExp.hasMatch(this);
  }
}
